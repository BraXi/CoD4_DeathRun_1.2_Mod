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
//
//	BraXi's Death Run Mod
//	(c) 2010-2020 Paulina Sokołowska
//
//	https://www.moddb.com/mods/braxs-death-run-mod
//
//	Twitter: https://twitter.com/TheBraXi
//	GitHub: https://github.com/BraXi/
//
//	E-mail: paulinabraxi somewhere at gmail.com

/*
	In this script you can load your own plugins from "\mods\<fs_game>\plugins\" directory or IWD package.

	=====

	LoadPlugin( plugins\PLUGIN_SCRIPT::ENTRY_POINT, PLUGIN_NAME, PLUGIN_AUTHOR )

	PLUGIN_SCRIPT	- Script file name without ".gsc" extension, ex. "example"
	ENTRY_POINT		- Plugin function called once a round to load script, if you
					use 'main' mod will call function main( modVersion ) from plugin file
	PLUGIN_NAME		- Name of the plugin, fox example "Extreme DR"
	PLUGIN_AUTHOR	- Plugin author's name


	NOTE!
	Plugins might be disabled via dvar "dr_usePlugins" 
*/

main()
{
	//
	// syntax is as follows:
	// LoadPlugin( pluginScript, name, author );
	// pluginScript - a .gsc file to load
	//

	/* === BEGIN === */

//	LoadPlugin( plugins\vip::init, "Weapon", "BraXi" );
	LoadPlugin( plugins\antiwallbang::init, "Anti-Wallbang", "Viking" );
	LoadPlugin( plugins\_nomusic::init, "No Double Music", "BraXi" );
//	LoadPlugin( plugins\_efr::init, "Unlimit Free Run Rounds", "Rycoon" );
	LoadPlugin( plugins\qubefix::init, "Qube Fix", "Darmuh" );

	// Map specific plugins, hacks here
	if( getDvar("mapname") == ("mp_deathrun_skypillar") )
		LoadPlugin( plugins\skypillarbugfix::init, "Sky Pillar Bug Fix", "Duffman" );
	if(getDvar("mapname") == "mp_dr_sm_world")
		LoadPlugin( plugins\mariobugfix::init, "Mario Cloud bugfix", "DuffMan" );
	if(getDvar("mapname") != "mp_deathrun_qube")
		setDvar("g_knockback",1000);

	/* ==== END ==== */
}



// ===== DO NOT EDIT ANYTHING UNDER THIS LINE ===== //
LoadPlugin( pluginScript, name, author )
{
	thread [[ pluginScript ]]( game["DeathRunVersion"] );
	println( "" + name + " ^7plugin created by " + author + "\n" );
}
