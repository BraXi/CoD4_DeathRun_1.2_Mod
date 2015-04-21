/////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////
////|         |///|        |///|       |/\  \/////  /////
////|  |////  |///|  |//|  |///|  |/|  |//\  \///  //////
////|  |////  |///|  |//|  |///|  |/|  |///\  \/  ///////
////|          |//|  |//|  |///|       |////\    ////////
////|  |////|  |//|         |//|  |/|  |/////    \///////
////|  |////|  |//|  |///|  |//|  |/|  |////  /\  \//////
////|          |//|__|///|__|//|__|/|__|///  ///\  \/////
//////////////////////////////////////////__/////\__\////
/////////////////////////////////////////////////////////
/*
	BraX's Zombie Mod
	
	Xfire: maciusiak
	E-mail: maciusiakpl@o2.pl / brax@brax-online.pl
	Website: www.brax-online.pl

	[DO NOT COPY WITHOUT PERMISSION]

	This script controls perks.
*/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;

onPlayerSpawned()
{
	self clearPerks();
	if ( !level.gameEnded && self.pers["team"] == "allies" )
	{
		perks = getPerks( self );
		for (i = 0; i < perks.size; i++ )
		{
			if( !isSubStr( perks[i], "_mp" ) && !isSubStr( perks[i], "_bx" ) && perks[i] != "specialty_null" ) //|| !isSubStr( perks[i], "_null" ) || !isSubStr( perks[i], "_bx" ) )
				self setPerk( perks[i] );

			self showPerk( i, perks[i], -50 );
		}
		self thread hidePerksAfterTime( 3.0 );
		self thread hidePerksOnDeath();
	}
	else //zombies don't use perks
	{
		self.specialty[0] = "specialty_null";
		self.specialty[1] = "specialty_null";
		self.specialty[2] = "specialty_null";
		self.specialty[3] = "specialty_null";
	}

	// last stand perk
	self.lastStand = undefined;
	self.useLastStandParams = undefined;
	self.lastStandParams = undefined;
}

lastStandTimer( delay )
{
	self endon( "death" );
	self endon( "disconnect" );
	self endon( "game_ended" );
	
	self thread lastStandWaittillDeath();
	
	self.lastStand = true;
	self setLowerMessage( &"PLATFORM_COWARDS_WAY_OUT" );
	
	self thread lastStandAllowSuicide();
	self thread lastStandKeepOverlay();

	wait delay;
	
	self thread LastStandBleedOut();
}

LastStandBleedOut()
{
	self.useLastStandParams = true;
	self ensureLastStandParamsValidity();
	self suicide();
}

ensureLastStandParamsValidity()
{
	// attacker may have become undefined if the player that killed me has disconnected
	if ( !isDefined( self.lastStandParams.attacker ) )
		self.lastStandParams.attacker = self;
}

lastStandAllowSuicide()
{
	self endon( "death" );
	self endon( "disconnect" );
	self endon( "game over" );
	
	while(1)
	{
		if ( self useButtonPressed() )
		{
			pressStartTime = gettime();
			while ( self useButtonPressed() )
			{
				wait .05;
				if ( gettime() - pressStartTime > 700 )
					break;
			}
			if ( gettime() - pressStartTime > 700 )
				break;
		}
		wait .05;
	}
	
	self thread LastStandBleedOut();
}

lastStandKeepOverlay()
{
	self endon( "death" );
	self endon( "disconnect" );
	self endon( "game over" );
	
	// keep the health overlay going by making code think the player is getting damaged
	while(1)
	{
		self.health = 2;
		wait .05;
		self.health = 1;
		wait .5;
	}
}

lastStandWaittillDeath()
{
	self endon( "disconnect" );
	
	self waittill( "death" );
	
	self clearLowerMessage();
	self.lastStand = undefined;
}

mayDoLastStand( sWeapon, sMeansOfDeath )
{
	/*if ( sMeansOfDeath == "MOD_FALLING" || sMeansOfDeath == "MOD_MELEE" )
		return true;
	*/

	return true;
}


getPerks( player )
{
	perks[0] = "specialty_null";
	perks[1] = "specialty_null";
	perks[2] = "specialty_null";
	perks[3] = "specialty_null";
	
	if ( isPlayer( player ) )
	{
		if ( isDefined( player.specialty[0] ) )
			perks[0] = player.specialty[0];
		if ( isDefined( player.specialty[1] ) )
			perks[1] = player.specialty[1];
		if ( isDefined( player.specialty[2] ) )
			perks[2] = player.specialty[2];
		if ( isDefined( player.specialty[3] ) )
			perks[3] = player.specialty[3];
	}
	
	return perks;
}

hidePerksAfterTime( delay )
{
	self endon("disconnect");
	self endon("perks_hidden");
	
	wait delay;
	
	self thread hidePerk( 0, 2.0 );
	self thread hidePerk( 1, 2.0 );
	self thread hidePerk( 2, 2.0 );
	self thread hidePerk( 3, 2.0 );
	self notify("perks_hidden");
}

hidePerksOnDeath()
{
	self endon("disconnect");
	self endon("perks_hidden");

	self waittill("death");
	
	self hidePerk( 0 );
	self hidePerk( 1 );
	self hidePerk( 2 );
	self hidePerk( 3 );
	self notify("perks_hidden");
}