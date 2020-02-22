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
	(c) 2010-2020 Paulina Sokołowska

	https://www.moddb.com/mods/braxs-death-run-mod

	Twitter: https://twitter.com/TheBraXi
	GitHub: https://github.com/BraXi/

	E-mail: paulinabraxi somewhere at gmail.com
*/

setPlayerModel()
{
	self detachAll();
	if( self.pers["team"] == "allies" )
	{
		id = self getStat( 980 );

		if( id >= level.numCharacters )
			id = level.numCharacters-1;
		else if( id < 0 )
			id = 0;

		self setModel( level.characterInfo[id]["model"] );
		self setViewModel( level.characterInfo[id]["handsModel"] );

		if( self.model == "body_mp_usmc_woodland_sniper" )
		{
			self attach("head_mp_usmc_ghillie", "", true);
		}
	}
	else
	{
		self setModel( "body_mp_usmc_cqb" );
		self setViewModel( "viewmodel_hands_zombie" );
	}
}

setHealth()
{
	self.maxhealth = 10;
	switch( self.pers["team"] )
	{
	case "allies":
		self.maxhealth = level.dvar["allies_health"];
		break;
	case "axis":
		self.maxhealth = level.dvar["axis_health"];
		break;
	}
	self.health = self.maxhealth;
}

setSpeed()
{
	speed = 1.0;
	switch( self.pers["team"] )
	{
	case "allies":
		speed = level.dvar["allies_speed"];
		break;
	case "axis":
		speed = level.dvar["axis_speed"];
		break;
	}
	self setMoveSpeedScale( speed );
}

setTeam( team )
{
	if( self.pers["team"] == team )
		return;

	if( isAlive( self ) )
		self suicide();
	
	self.pers["weapon"] = "none";
	self.pers["team"] = team;
	self.team = team;
	self.sessionteam = team;

	menu = game["menu_team"];
	if( team == "allies" )
	{
		self.pers["weapon"] = "colt45_mp";
	}
	else if( team == "axis" )
	{
		self.pers["weapon"] = "knife_mp";
	}
	self setClientDvars( "g_scriptMainMenu", menu );
}

setSpectatePermissions()
{
	self allowSpectateTeam( "allies", true );
	self allowSpectateTeam( "axis", true );
	self allowSpectateTeam( "none", false );
}
