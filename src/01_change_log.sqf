private _changelog = [
	"EZM Plus Version 1.0.0",
	"Removed backdoor function.",
	"Refactored codebase. 1 single file to 166 separate, manageable files.",
	"Created build system for final script."
];

private _changelogString = "";
{
	_changelogString = _changelogString + "- " + _x + (toString [13,10]);
}forEach _changelog;