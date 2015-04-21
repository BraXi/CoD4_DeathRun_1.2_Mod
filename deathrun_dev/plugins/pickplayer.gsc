//
// Plugin name: Trigger Spawner
// Author: BraXi
// Version: 1.0
// Website: www.braxi.cba.pl
// Description: Displays welcome message for newly connected player
//
// This plugin was designed for Death Run, after some tweaks it may also work with 
// other mods, but please give credits to me if you find this useful in your mod.
//

#include maps\mp\_utility;
#include common_scripts\utility;
#include braxi\_common;

init( modVersion )
{
	while( 1 )
	{
		level waittill( "player_spawn", player );
	
		player notify( "stop picking thread" );
		player thread pickPlayer();
	}
}

pickPlayer()
{
    self endon( "disconnect" );
    self endon( "spawned_player" );
    self endon( "joined_spectators" );
    self endon( "death" );
	self endon( "stop picking thread" );

	if( !self.pers["admin"] )
		return;

	if( !isDefined( self.hud_admin_pick ) )
	{
		self.hud_admin_pick = braxi\_mod::addTextHud( self, 10, 220, 1, "left", "middle", 1.4 );
		self.hud_admin_pick.hidewheninmenu = true;
	}

	self.selectedPlayer = undefined;

	while( self isReallyAlive() )
	{
		wait 0.1;

		trace = bulletTrace( self getTagOrigin( "j_head" ), self getTagOrigin( "j_head" ) + vector_scale( anglesToForward(self getPlayerAngles()), 2048), true, self );

		if( self secondaryOffhandButtonPressed() )
		{
			if( !isDefined( self.selectedPlayer ) )
			{
				if( !isDefined( trace["entity"] ) || !isPlayer( trace["entity"] ) )
					continue;
				self.selectedPlayer = trace["entity"];
			}
			else
			{
				if( isDefined( trace["entity"] ) && isPlayer( trace["entity"] ) )
				{

				}
			}
		}

	}
}
