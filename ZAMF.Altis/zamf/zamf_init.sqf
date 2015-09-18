// Initializes many ZAMF functionality in their correct order.
// Takes as input an array of many strings that turn each component on. If the string is absent the feature wont be enabled. They can be provided in any order.

/* Example:
[
// Remove any of these strings to disable a feature. All of these must be in lowercase but can be in any order.

"disable_playable_ai",       // Makes the AI that takes a player slot effectively vacant (wont do anything).
"disable_playable_ai_speak", // Prevent the avatar that the player controls from shouting in game.
//"leave_group",             // Makes the player leave whatever group he/she starts in and join a new one alone.
"spectate_on_death",         // As soon as a player dies, he/she spectates (even if respawn is enabled).
"tfar_config",		     // ZA Specific config settings for TFAR, such as disabling auto microdagr and backpack radios.
"mcc_limit",		     // Limit MCC to Admins.
"zeusify",		     // Make sure that all units are detected by zeus.
"logistics",		     // Enable a logistics script
"zam_res"		     // Enable ZAM Resume

] call compile preprocessfilelinenumbers "zamf\zamf_init.sqf";
*/

// Shortens script calls
#ifndef execNow
#define execNow call compile preprocessfilelinenumbers
#endif

private ["_input"];
_input = _this;

// Set Respawn timer
if !(isNil "zamf_respawntimer") then {
	[] spawn {
		waitUntil {sleep 1; time > 1};
		setPlayerRespawnTime zamf_respawntimer;
	};
};

// Define Paramaters for editor
if (isNil "paramsArray") then {
	execNow "zamf\params\params_editor.sqf";
};

// Name Paramaters for easy use
execNow "zamf\params\params_name.sqf";

// Time Parameter
[PARAMS_hour, PARAMS_minute, PARAMS_day] execVM "zamf\world\world_time.sqf";

// View Distance Parameter
PARAMS_def_view_distance execNow "zamf\world\world_view_distance.sqf";

// Weather Parameter
[PARAMS_clouds, PARAMS_fogValue, PARAMS_fogDecay, PARAMS_fogBase] execVM "zamf\world\world_weather.sqf";

// Disable AI for all playable units
if ("disable_playable_ai" in _input) then {execVM "zamf\player\disable_playable.sqf"};

// Disable Ai Speak for playable characters
if ("disable_playable_ai_speak" in _input) then {execVM "zamf\player\disable_ai_speak.sqf"};

// Player automatically leaves group at start
if ("leave_group" in _input) then {execVM "zamf\player\leave_grp.sqf"};

// Spectate on death
if ("spectate_on_death" in _input) then {[] execVM "CSSA3\CSSA3_init.sqf"};

// Handle enabling or disabling of ZA Mods
zam_res_enabled = if ("zam_res" in _input) then {True} else {False};

// TFAR Config
if ("tfar_config" in _input) then {
	tf_no_auto_long_range_radio = true;
	TF_give_microdagr_to_soldier = false;
};

// MCC Limits
//--------------------- Who can access MCC leave "all" for everbody --------------------------------
// Should be MCC_allowedPlayers = ["12321","1321123"];
// Host or server admin will always have access
if ("mcc_limit" in _input) then {MCC_allowedPlayers = [];};

// Zeusify all units
if ((isServer) && ("zeusify" in _input)) then {
	{
		nul = [_x, true] execVM "zamf\zeus\ADV_zeus.sqf";
	} count allCurators;
};

// R3F Logistics
if ("logistics" in _input) then {execVM "R3F_LOG\init.sqf"};

// Don't show ranks
ZAM_showNames_ranks = false;

// Finish world initialization before mission is launched.
finishMissionInit;
