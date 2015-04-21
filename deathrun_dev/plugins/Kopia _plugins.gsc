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
	BraXi's Death Run Mod 1.2
	
	Xfire: braxpl
	E-mail: paulina1295@o2.pl
	Website: www.braxi.org

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
	// LoadPlugin( pluginScript, name, author )
	//

	/* === BEGIN === */

	//LoadPlugin( plugins\triggerspawner::init, "Weapon", "BraXi" );

	/* ==== END ==== */
}



// ===== DO NOT EDIT ANYTHING UNDER THIS LINE ===== //
LoadPlugin( pluginScript, name, author )
{
	thread [[ pluginScript ]]( game["DeathRunVersion"] );
	println( "" + name + " ^7plugin created by " + author + "\n" );
}