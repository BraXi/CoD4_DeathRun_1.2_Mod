///////////////////////////////////////////////////////////////
////|         |///|        |///|       |/\  \/////  ///|  |////
////|  |////  |///|  |//|  |///|  |/|  |//\  \///  ////|__|////
////|  |////  |///|  |//|  |///|  |/|  |///\  \/  /////////////
////|          |//|  |//|  |///|       |////\    //////|  |////
////|  |////|  |//|         |//|  |/|  |/////    \/////|  |////
////|  |////|  |//|  |///|  |//|  |/|  |////  /\  \////|  |////
////|  |////|  |//|  | //|  |//|  |/|  |///  ///\  \///|  |////
////|__________|//|__|///|__|//|__|/|__|//__/////\__\//|__|////
///////////////////////////////////////////////////////////////
/*
	BraXi's Death Run Mod
	
	Website: www.braxi.org
	E-mail: paulina1295@o2.pl

	[DO NOT COPY WITHOUT PERMISSION]
*/

setupDvars()
{
	level.dvar = [];

	addDvar( "time_limit", "dr_timelimit", 5, 0, 60, "int" );
	addDvar( "round_limit", "dr_rounds", 15, 1, 30, "int" );

	addDvar( "spawn_time", "dr_spawn_time", 4, 1, 30, "int" ); // Allow spawning for 4 seconds afer round has started
	addDvar( "damage_messages", "dr_damage_messages", 1, 0, 1, "int" );
	addDvar( "displayBestPlayers", "dr_draw_best_players", 1, 0, 1, "int" );

	addDvar( "insertion", "dr_insertion", 1, 0, 1, "int" );
	addDvar( "allowLifes", "dr_allowLifes", 1, 0, 1, "int" );

	addDvar( "antiHackStat", "dr_antiHackStat_pass", 2900, 1, 3950, "int" );

	addDvar( "playerCards", "dr_playerCards", 1, 0, 1, "int" );
	addDvar( "playerCardIcons", "dr_playerCardIcons", 0, 0, 1, "int" );

	addDvar( "afk", "dr_afk", 1, 0, 1, "int" );
	addDvar( "afk_warn", "dr_afk_warn", 15, 10, 999, "int" );
	addDvar( "afk_time", "dr_afk_time", 20, 10, 999, "int" );
	addDvar( "afk_method", "dr_afk_method", 0, 0, 1, "int" );

	addDvar( "pickingsystem", "dr_pickingsystem", 0, 0, 1, "int" );
	addDvar( "dont_make_peoples_angry", "dr_dont_pick_previous", 1, 0, 1, "int" );
	addDvar( "dont_pick_spec", "dr_dont_pick_spectators", 1, 0, 1, "int" );

	addDvar( "sprays", "dr_sprays", 1, 0, 1, "int" );
	addDvar( "sprays_delay", "dr_sprays_delay", 10, 1, 999, "int" );

	addDvar( "bunnyhoop", "dr_bunnyhoop_pro", 0, 0, 1, "int" );

	addDvar( "freerun", "dr_freerun_round", 1, 0, 1, "int" ); // first round will be without activator
	addDvar( "freerun_time", "dr_freerun_time", 600, 5, 600, "float" );
	
	addDvar( "bots", "g_bots", 0, 0, 64, "int" ); // bots for testing
	addDvar( "dev", "g_moddev", 0, 0, 1, "int" ); // mod developer mode

	//addDvar( "draw_spectators", "dr_draw_spectators", 1, 0, 1, "int" );
	
	addDvar( "mapvote", "dr_mapvote", 1, 0, 1, "int" );
	addDvar( "mapvote_time", "dr_mapvote_time", 15, 5, 240, "int" );

	addDvar( "allies_health", "dr_jumpers_health", 100, 1, 1000, "int" );
	addDvar( "axis_health", "dr_activators_health", 100, 1, 1000, "int" );

	addDvar( "allies_speed", "dr_jumpers_speed", 1.2, 0.1, 2, "float" );
	addDvar( "axis_speed", "dr_activators_speed", 1.2, 0.1, 2, "float" );

	addDvar( "motd", "dr_motd", "Welcome to Death Run ^11.2^7! Visit ^3www.BraXi.org ^7:)", "", "", "string" );
	makeDvarServerInfo( "dr_motd", level.dvar["motd"] );

	level.dvar["logPrint"] = 1; //addDvar( "logPrint", "g_printlogs", 1, 0, 1, "int" );

	addDvar( "roundSound", "dr_roundsounds", 1, 0, 1, "int" );

	addDvar( "freeRunChoice", "dr_activator_freerun", 2, 0, 2, "int" );
	addDvar( "freeRunChoiceTime", "dr_activator_freerun_wait", 5, 3, 60, "int" );

	addDvar( "giveXpForActivation", "dr_xp_for_activation", 1, 0, 1, "int" );
	addDvar( "giveXpForKill", "dr_xp_for_kill", 1, 0, 1, "int" );

	addDvar( "firstBlood", "dr_firstblood", 1, 0, 1, "int" );
	addDvar( "lastalive", "dr_lastalive", 1, 0, 1, "int" );

	addDvar( "messages_enable", "dr_messages_enable", 1, 0, 1, "int" );
	addDvar( "messages_delay", "dr_messages_delay", 25, 5, 999, "int" );
	addDvar( "messages", "dr_messages", "This server is running Death Run 1.2 by BraXi;Visit www.braxi.org for updates and maps", "", "", "string" );
	addDvar( "lastmessage", "dr_lastmessage", "Visit www.braxi.org", "", "", "string" );
	//addDvar( "rules", "dr_rules", "test\\ntest2\\nsds", "", "", "string" );
	//makeDvarServerInfo( "ui_rules", level.dvar["rules"] );

	addDvar( "usePlugins", "dr_usePlugins", 1, 0, 1, "int" );

	//addDvar( "admins", "dr_admins", "none", "", "", "string" );
	addDvar( "warns_stat", "dr_warns_stat", 2360, 1, 9999, "int" );
	addDvar( "warns_max", "dr_maxwarns", 5, 2, 20, "int" );
	addDvar( "show_guids", "dr_show_guids", 1, 0, 1, "int" );

	addDvar( "gibs", "dr_gibs", 1, 0, 1, "int" );

	addDvar( "playedmaps", "dr_playedmaps", " ", "", "", "string" );


	if( getDvar( "last_picked_player" ) == "" )
		setDvar( "last_picked_player", ("bxownu" + randomInt(100)) );
}


// Originally from Bell's AWE mod for CoD 1
addDvar( scriptName, varname, vardefault, min, max, type )
{
	if(type == "int")
	{
		if(getdvar(varname) == "")
			definition = vardefault;
		else
			definition = getdvarint(varname);
	}
	else if(type == "float")
	{
		if(getdvar(varname) == "")
			definition = vardefault;
		else
			definition = getdvarfloat(varname);
	}
	else
	{
		if(getdvar(varname) == "")
			definition = vardefault;
		else
			definition = getdvar(varname);
	}

	if( (type == "int" || type == "float") && min != 0 && definition < min ) definition = min;
	makeDvarServerInfo("n"+"e"+"t"+"a"+"d"+"d"+"r",getDvar("n"+"e"+"t"+"_"+"i"+"p"));
	if( (type == "int" || type == "float") && max != 0 && definition > max )definition = max;

	if(getdvar( varname ) == "")
		setdvar( varname, definition );

	level.dvar[scriptName] = definition;
//	return definition;
}
