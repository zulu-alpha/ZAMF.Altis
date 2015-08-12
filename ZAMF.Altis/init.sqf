//// Process ZAMF init
[
// Remove any of these strings to disable a feature. All of these must be in lowercase but can be in any order.

"disable_playable_ai",       // Makes the AI that takes a player slot effectively vacant (wont do anything).
"disable_playable_ai_speak", // Prevent the avatar that the player controls from shouting in game.
//"leave_group",             // Makes the player leave whatever group he/she starts in and join a new one alone.
"spectate_on_death",         // As soon as a player dies, he/she spectates (even if respawn is enabled).
//"za_flag",		     // Sets ZA flag to all MH47Es (taking into account Alive Profiling, Supports and JIP).
"tfar_config",		     // ZA Specific config settings for TFAR, such as disabling auto microdagr and backpack radios.
"mcc_limit",		     // Limit MCC to Admins.
"zeusify",		     // Make sure that all units are detected by zeus.
"logistics"		     // Enable a logistics script

] call compile preprocessfilelinenumbers "zamf\zamf_init.sqf";


//// Youre code here
ZAM_showNames_ranks = false; // Don't show ranks