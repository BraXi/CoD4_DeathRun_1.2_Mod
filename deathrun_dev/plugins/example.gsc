//
// Plugin name: <name>
// Author: <author>
// Version: <version>
// Website: <your website>
//
// This plugin was designed for Death Run, after some tweaks it may also work with 
// other mods, but please give credits to me if you find this useful in your mod.
//

init( modVersion )
{
	// addDvar( <script name>, <dvar name>, <default value>, <minimum value>, <max value>, <type: int, float and string>
	braxi\_dvar::addDvar( "example_enabled", "example_enabled", 1, 0, 1, "int" );
	
	// level.dvar[ <script name> ] is dvar's value
	if( level.dvar["example_enabled"] == 0 || modVersion < 11 )  // is plugin enabled and is deathrun version 1.1 or higher?
		return; //return when plugin is disabled

	precacheItem( "deserteagle_mp" );

	thread playerSpawned();
	thread playerKilled();
}

playerSpawned()
{
	while( 1 ) //we want to receive all events called "player_spawn"
	{
		//YOU CAN NOT ADD ANY WAITS INSIDE THIS LOOP

		level waittill( "player_spawn", who ); //code under waittill will be executed after player spawned
	
		who takeAllWeapons(); // take away all his/her weapons
		
		// if its jumper then give him desert eagle, if its activator we will give him colt
		if( who.pers["team"] == "allies" )
			weapon = "deserteagle_mp";
		else
			weapon = "colt45_mp";

		who takeWeapon( weapon );
		who giveWeapon( weapon );
		who giveMaxAmmo( weapon );
		who switchToWeapon( weapon );
	}
}

playerKilled()
{
	while( 1 ) 
	{
		level waittill( "player_killed", who, eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration );
		who iPrintlnBold( "^1Noone lives forever, Mr. " + self.name );
		
		if( isPlayer( attacker ) ) //if we were kill by player then show him little message
		{
			attacker iPrintlnBold( "^1How dear you are to kill " + who.name + " ?" );
		}
	}
}
