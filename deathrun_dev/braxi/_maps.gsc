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

	=== INFO ===
		In this script you can add following things:
			- blockers	[ spawnCollision( (X,Y,Z), width, height ) ]
			- arrays of activation triggers for specified maps
*/

#include braxi\_common;

getMapNameString( mapName ) 
{
	tokens = strTok( toLower( mapName ), "_" ); // mp 0, deathrun/dr 1, name 2, (optional)version 3

	if( tokens.size < 2  || !tokens.size )
		return mapName;

//	if( tokens[1] != "deathrun" && tokens[1] != "dr" )
//	{
//		iPrintlnBold( "Map '" + mapName + " is not for use with Death Run Mod, please contact server administrator" );
//		level.wrongMap = true;
//	}
	
	return tokens[2];
}
/*
getMapNameString( mapName ) 
{
	switch( toLower( mapName ) )
	{
		case "mp_deathrun_darkness":
			mapName = "Darkness";
			break;
		case "mp_deathrun_long":
			mapName = "Long";
			break;
		case "mp_deathrun_watchit":
		case "mp_deathrun_watchit_v2":
		case "mp_deathrun_watchit_v3":
			mapName = "Watch It";
			break;
		case "mp_deathrun_takecare":
			mapName = "Take Care";
			break;
		case "mp_deathrun_glass":
			mapName = "Glass";
			break;
		case "mp_deathrun_dungeon":
			mapName = "Dungeon";
			break;
		case "mp_deathrun_supermario":
		case "mp_deathrun_supermario_v2":
			mapName = "Super Mario";
			break;
		case "mp_deathrun_short":
		case "mp_deathrun_short_v2":
		case "mp_deathrun_short_v3":
		case "mp_deathrun_short_v4":
			mapName = "Short";
			break;
		case "mp_deathrun_grassy":
		case "mp_deathrun_grassy_v4":
			mapName = "Grassy";
			break;
		case "mp_dr_bananaphone":
			mapName = "Banana Phone";
			break;
		case "mp_deathrun_portal":
		case "mp_deathrun_portal_v2":
		case "mp_deathrun_portal_v3":
		case "mp_deathrun_portal_v4":
			mapName = "Portal";
			break;
	}
	return mapName;
}
*/

init()
{
	switch ( level.mapName )
	{
	case "mp_deathrun_cave":
		trigger = spawn( "trigger_radius", (2226.29, 3548.81, 4.125), 0, 55, 55 );
		trigger.targetname = "endmap_trig";
		break;
	
	case "mp_deathrun_supermario":
		trigger = spawn( "trigger_radius", (293.538, -1472, 8.12501), 0, 40, 50 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_deathrun_glass":
		trigger = spawn( "trigger_radius", (106.077, 2241.14, 64.125), 0, 55, 50 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_deathrun_azteca":
		trigger = spawn( "trigger_radius", (6.59441, -808.602, 32.125), 0, 60, 50 );
		trigger.targetname = "endmap_trig";
		break;

	case "mp_deathrun_colourful":
		trigger = spawn( "trigger_radius", (350.749, 197.533, 688.125), 0, 65, 40 );
		trigger.targetname = "endmap_trig";
		break;

	case "mp_deathrun_escape2":
		trigger = spawn( "trigger_radius", (-6464.2, -2495.73, 184.125), 0, 60, 60 );
		trigger.targetname = "endmap_trig";
		break;

	case "mp_deathrun_ruin2":
		trigger = spawn( "trigger_radius", (9329.7, 380.853, 128.125), 0, 255, 140 );
		trigger.targetname = "endmap_trig";
		break;

// ===== Thanks to DuffMan for these ===== //
	case "mp_dr_bigfall":
		trigger = spawn( "trigger_radius", (-5484.02, -123.487, -12273.5), 0, 96, 48 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_deathrun_scary":
		trigger = spawn( "trigger_radius", (1.12299, -4825.81, 624.125), 0, 96, 48 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_dr_bounce":
		trigger = spawn( "trigger_radius", (-958.809, 5989.51, 0.125), 0, 96, 48 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_dr_apocalypse_v2":
		trigger = spawn( "trigger_radius", (-7.09212, 3671.36, 976.125), 0, 96, 48 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_deathrun_framey_v2":
		trigger = spawn( "trigger_radius", (-2423.35, 794.684, 4.90718), 0, 96, 48 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_deathrun_backlot":
		trigger = spawn( "trigger_radius", (-939.774, 222.606, 106.125), 0, 96, 48 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_deathrun_max":
		trigger = spawn( "trigger_radius", (671.125, 13371.2, 0.125002), 0, 96, 48 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_dr_terror":
		trigger = spawn( "trigger_radius", (26.0624, 1312.15, 202.402), 0, 96, 48 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_dr_pool":
		trigger = spawn( "trigger_radius", (-876.881, 678.355, 184.125), 0, 96, 48 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_deathrun_skypillar":
		trigger = spawn( "trigger_radius", (-2044.31, -338.131, 1057.13), 0, 96, 48 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_dr_ssc_nothing":
		trigger = spawn( "trigger_radius", (228.711, -81.1929, 243.998), 0, 96, 48 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_deathrun_diehard":
		trigger = spawn( "trigger_radius", (-1095.76, -2331.43, 643.575), 0, 96, 48 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_deathrun_metal2":
		trigger = spawn( "trigger_radius", (-465.821, 975.085, 16.125), 0, 96, 48 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_deathrun_greenland":
		trigger = spawn( "trigger_radius", (175.547, -756.876, 144.125), 0, 96, 48 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_dr_sm_world":
		trigger = spawn( "trigger_radius", (-3499.54, -2704.88, 64.125), 0, 96, 48 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_deathrun_palm":
		trigger = spawn( "trigger_radius", (251.21, -256.368, 384.125), 0, 96, 48 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_deathrun_watchit_v3":
		trigger = spawn( "trigger_radius", (393.125, 1254.06, 640.125), 0, 96, 48 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_deathrun_city":
		trigger = spawn( "trigger_radius", (1271.56, -847.444, 0.124998), 0, 96, 48 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_deathrun_jailhouse":
		trigger = spawn( "trigger_radius", (-4908.72, 447.658, 218.524), 0, 96, 48 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_deathrun_crazy":
		trigger = spawn( "trigger_radius", (757.689, -2349.56, 1040.13), 0, 96, 48 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_dr_finalshuttle":
		trigger = spawn( "trigger_radius", (339.854, 2194.73, 428.125), 0, 96, 48 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_dr_indipyramid":
		trigger = spawn( "trigger_radius", (-273.908, 87.884, -229.875), 0, 196, 48 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_dr_bananaphone_v2":
		trigger = spawn( "trigger_radius", (2445.84, -424.875, 176.125), 0, 96, 48 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_deathrun_zero":
		trigger = spawn( "trigger_radius", (-1860.46, -8.91591, 16.125), 0, 96, 48 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_deathrun_wood_v3":
		trigger = spawn( "trigger_radius", (2884.08, 1041.26, 1024.06), 0, 96, 48 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_deathrun_takecare":
		trigger = spawn( "trigger_radius", (-701.125, 931.948, 192.125), 0, 96, 48 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_deathrun_portal_v3":
		trigger = spawn( "trigger_radius", (-4064.87, 1593.28, -63.875), 0, 96, 48 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_deathrun_minecraft":
		trigger = spawn( "trigger_radius", (-656.331, 1533.39, -31.875), 0, 96, 48 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_deathrun_liferun":
		trigger = spawn( "trigger_radius", (-279.875, 4833.46, 168.125), 0, 96, 48 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_deathrun_grassy":
		trigger = spawn( "trigger_radius", (2917.52, -1518.72, 64.125), 0, 96, 48 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_deathrun_dungeon":
		trigger = spawn( "trigger_radius", (1855.13, -2200.61, -183.875), 0, 96, 48 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_deathrun_dirt":
		trigger = spawn( "trigger_radius", (-30.625, -839.474, 768.125), 0, 96, 48 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_deathrun_destroyed":
		trigger = spawn( "trigger_radius", (-9224.88, 125.72, 484.125), 0, 96, 48 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_deathrun_darkness":
		trigger = spawn( "trigger_radius", (985.723, -587.125, 16.125), 0, 96, 48 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_deathrun_clear":
		trigger = spawn( "trigger_radius", (-771.999, 520.011, 48.125), 0, 96, 48 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_dr_pacman":
		trigger = spawn( "trigger_radius", (41.1631, 600.943, 1033.63), 0, 96, 48 );
		trigger.targetname = "endmap_trig";
		break;
	case "mp_dr_jurapark":
		trigger = spawn( "trigger_radius", (1001.44, 2104.73, -60.875), 0, 96, 48 );
		break;
	}

//===//

	if( !isDefined( level.trapTriggers ) )
	{
		level.trapTriggers = [];
		switch ( level.mapName )
		{
		// BraXi's MAPS
		case "mp_deathrun_darkness":
			level.trapTriggers[level.trapTriggers.size] = getEnt( "t1", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "t2", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "t3", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "t4", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "t5", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "t6", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "t7", "targetname" );
			break;
		case "mp_deathrun_long":
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger1", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger2", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger3", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger4", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger5", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger7", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger8", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger9", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger10", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger11", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger12", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger13", "targetname" );
			spawnCollision( (112,3440,24), 70, 16 );
			spawnCollision( (16,3696,28), 70, 16 );
			spawnCollision( (-112,3440,28), 70, 16 );
			spawnCollision( (-112,3440,28), 70, 16 );
			spawnCollision( (1136,3936,28), 110, 16 );
			spawnCollision( (304,-352,20), 110, 48 );
			break;

		// Viking's MAPS
		case "mp_deathrun_watchit_v2":
		case "mp_deathrun_watchit_v3":
			level.trapTriggers[level.trapTriggers.size] = getEnt( "t1", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "t2", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "t3", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "t4", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "t5", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "t6", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "t7", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "t8", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "t9", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "t10", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "t11", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "t12", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "t13", "targetname" );
			break;

		// MR-X's MAPS
		case "mp_deathrun_takecare":
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trig_1", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trig_2", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trig_3", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trig_4", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trig_5", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trig_6", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trig_7", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trig_8", "targetname" );
			break;
		case "mp_deathrun_glass":
		case "mp_deathrun_dungeon":
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trig_1", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trig_2", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trig_3", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trig_4", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trig_5", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trig_6", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trig_7", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trig_8", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trig_9", "targetname" );
			break;
		case "mp_deathrun_supermario":

			level.trapTriggers[level.trapTriggers.size] = getEnt( "trig1", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trig2", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trig3", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trig4", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trig5", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trig6", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trig7", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trig8", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trig9", "targetname" );
			break;

		// Patrick's MAPS
		case "mp_deathrun_short":
		case "mp_deathrun_short_v2":
			level.trapTriggers[level.trapTriggers.size] = getEnt( "t1", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "t2", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "t3", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "t4", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "t5", "targetname" );
			break;
		
		// Rednose's MAPS
		case "mp_deathrun_grassy":
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger1", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger2", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger3", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger4", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger5", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger6", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger7", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger8", "targetname" );
			break;
		case "mp_deathrun_portal":
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger1", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger2", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger3", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger4", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger5", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger6", "targetname" );
			level.trapTriggers[level.trapTriggers.size] = getEnt( "trigger7", "targetname" );
			break;
		}
	}

	if( isDefined( level.trapTriggers ) )
	{
		level thread checkTrapUsage();
	}
}


checkTrapUsage()
{

	if( !level.trapTriggers.size )
	{
		warning( "checkTrapUsage() reported that level.trapTriggers.size is -1, add trap activation triggers to level.trapTriggers array and recompile FF" );
		warning( "Map doesn't support free run and XP for activation" );
		return;
	}

	for( i = 0; i < level.trapTriggers.size; i++ )
	{
		if ( level.dvar[ "freeRunChoice" ] == 2 )
		{
			level.trapTriggers[i] thread killFreeRunIfActivated();
		}
		if ( level.dvar[ "giveXpForActivation" ] )
		{
			level.trapTriggers[i] thread giveXpIfActivated();
		}
		level.trapTriggers[i] thread processTrapChallenge();
	}
}

processTrapChallenge()
{
	level endon( "death" );
	level endon( "delete" );
	level endon( "deleted" );

	while( isDefined( self ) )
	{
		self waittill( "trigger", who );
		if( who.pers["team"] == "axis" )
		{
			if( game["state"] != "playing" )
				return;
			who braxi\_missions::processChallenge( "ch_activated", 1 );
			break;
		}
	}
}
		

killFreeRunIfActivated()
{
	level endon( "death" );
	level endon( "delete" );
	level endon( "deleted" );
	level endon( "kill_free_run_choice" );

	//level.trapsDisabled
	while( isDefined( self ) )
	{
		self waittill( "trigger", who );
		if( who.pers["team"] == "axis" )
		{
			level.canCallFreeRun = false;
			if( !level.trapsDisabled )
			{
				//who iPrintlnBold( "You have activated trap and now you can't call free run" );
				level notify( "kill_free_run_choice" );
			}
			break;
		}
	}
}


giveXpIfActivated()
{
	level endon( "death" );
	level endon( "delete" );
	level endon( "deleted" );

	while( isDefined( self ) )
	{
		self waittill( "trigger", who );
		if( who.pers["team"] == "axis" )
		{
			if( game["state"] != "playing" )
				return;
			who braxi\_rank::giveRankXP( "trap_activation" );
			break;
		}
	}
}