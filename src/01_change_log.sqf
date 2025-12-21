private _changelog = [
	"Added ability to grant/revoke zeus access.",
	"Removed backdoor and ban list [used by old devs to abuse things/people.]",
	"Refactored codebase. 1 single file to 166 separate, manageable files."
];

private _changelogString = "";
{
	_changelogString = _changelogString + "- " + _x + (toString [13,10]);
}forEach _changelog;