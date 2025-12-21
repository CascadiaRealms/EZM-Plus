import os
from pathlib import Path
from datetime import datetime

def build_sqf(input_folder='src', output_file='Enhanced_Zeus_Modules_Plus.sqf', version='1.0.1'):
    search_path = Path(input_folder)
    
    if not search_path.exists():
        print(f"Error: Folder '{input_folder}' not found.")
        return

    # Find all .sqf files recursively
    # We sort them to ensure the build is deterministic (same every time)
    sqf_files = sorted(list(search_path.rglob('*.sqf')))

    if not sqf_files:
        print(f"No .sqf files found in {input_folder}")
        return

    print(f"Found {len(sqf_files)} files. Compiling...")

    with open(output_file, 'w', encoding='utf-8') as outfile:
        # Header for the compiled file
        outfile.write(f"comment 'Compiled on {datetime.now()}';\n")
        outfile.write(f"comment 'Source: {input_folder}/';\n\n")

        outfile.write('if(!isNull (findDisplay 312) && {!isNil "this"} && {!isNull this}) then {')
        outfile.write("\tdeleteVehicle this;\n")
        outfile.write('};\n\n[] spawn {\n\tMAZ_EZM_Version =')
        outfile.write(f'"V{version}";\n')

        for sqf_path in sqf_files:
            # Get relative path for the comment block (e.g., modules/core/init.sqf)
            relative_path = sqf_path.relative_to(search_path.parent)
            
            print(f"  [+] Adding: {relative_path}")
            
            # SQF Comment block to separate files
            outfile.write(f'\ncomment "##########################################";\n')
            outfile.write(f'comment "FILE: {relative_path}";')
            outfile.write(f'\ncomment "##########################################";\n\n')
            
            with open(sqf_path, 'r', encoding='utf-8') as infile:
                content = infile.read()
                outfile.write(content)
                
                # Ensure there's a newline so the next file doesn't 
                # start on the same line as a comment or code
                if not content.endswith('\n'):
                    outfile.write('\n')
                    
    print(f"\nSuccess! Framework compiled to: {output_file}")

if __name__ == "__main__":
    build_sqf()