/*
|============================================================================|
##############################################################################
##|       |##\  \####/  /##|        |##|        |##|        |##|   \####|  |##
##|   _   |###\  \##/  /###|  ______|##|   __   |##|   __   |##|    \###|  |##
##|  |_|  |####\  \/  /####|  |########|  |  |  |##|  |  |  |##|  \  \##|  |##
##|       |#####\    /#####|  |########|  |  |  |##|  |  |  |##|  |\  \#|  |##
##|       |######|  |######|  |########|  |  |  |##|  |  |  |##|  |#\  \|  |##
##|  |\  \#######|  |######|  |########|  |__|  |##|  |__|  |##|  |##\  |  |##
##|  |#\  \######|  |######|        |##|        |##|        |##|  |###\    |##
##|__|##\__\#####|__|######|________|##|________|##|________|##|__|####\___|##
##############################################################################
|============================================================================|

	Plugin: Endless Free Run
	Author: Rycoon
	Version: 1.0 ( Beta )
	Contact: braxi.org/forum -> PM to 'Phaedrean'
	
	This plugin will play the free run round until enough players are connected.
|============================================================================|
*/

#include braxi\_dvar;
#include braxi\_common;
#include maps\mp\gametypes\_hud_util;

init( modVers )
{
	addDvar( "pi_efr", "plugin_efr_enable", 1, 0, 1, "int" );
	addDvar( "pi_efr_vision", "plugin_efr_vision", 1, 0, 1, "int" );
	addDvar( "pi_efr_rt", "plugin_efr_restarttime", 3, 3, 15, "int" );
	
	wait 2;
	if( getPlayingPlayers().size > 2 || level.freeRun || !level.dvar["pi_efr"] )
		return;

	level.freeRun = true;		//Do not count deaths
	game["state"] = "playing";
	level notify( "kill logic" );
	
	if( isDefined( level.hud_jumpers ) )
		level.hud_jumpers.alpha = 0;
	
	if( isDefined( level.hud_time ) )
		level.hud_time.alpha = 0;
	
	if( isDefined( level.matchStartText ) )
		level.matchStartText destroy();
	
	braxi\_mod::RoundStartTimer();
	players = getAllPlayers();
	for( i = 0; i < players.size; i++ )
	{
		if( players[i] isPlaying() )
		{
			players[i] unLink();
			players[i] enableWeapons();
		}
	}
	
	level.matchStartText = createServerFontString( "objective", 1.5 );
	level.matchStartText setPoint( "CENTER", "BOTTOM", 0, -20 );
	level.matchStartText.sort = 1001;
	level.matchStartText setText( level.text["waiting_for_players"] );
	level.matchStartText.foreground = false;
	level.matchStartText.hidewheninmenu = true;
	
	if( level.dvar["pi_efr_vision"] )
		visionSetNaked( level.mapName, 2.0 );
	
	while( getPlayingPlayers().size < 3 )
		wait 0.5;
	
	if( isDefined( level.matchStartText ) )
		level.matchStartText destroy();
	
	iPrintlnBold( "^2Enough players detected! Starting in " + level.dvar["pi_efr_rt"] + " seconds..." );
	wait level.dvar["pi_efr_rt"];
	level.freeRun = false;
	map_restart( true );
}
