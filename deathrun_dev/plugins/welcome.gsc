//
// Plugin name: Welcome Message
// Author: BraXi
// Version: 1.0
// Website: www.braxi.org
// Description: Displays welcome message for newly connected player
//
// This plugin was designed for Death Run, after some tweaks it may also work with 
// other mods, but please give credits to me if you find this useful in your mod.
//

init( modVersion )
{
	braxi\_dvar::addDvar( "welcome_message1", "welcome_message1", "Welcome to ^1AfterLife ^7Death Run server!", "", "", "string" );
	braxi\_dvar::addDvar( "welcome_message2", "welcome_message2", "^3Visit www.AfterLifeGaming.net", "", "", "string" );

	if( getDvar( "welcome_player" ) == "" )
		setDvar( "welcome_player", "0" );

	thread playerSpawned();
}

playerSpawned()
{
	while( 1 )
	{
		level waittill( "player_spawn", player );
	
		if( !isDefined( player.pers["welcomemsg"] ) )
		{
			player.pers["welcomemsg"] = true;
			player thread displayMessage();
		}
	}
}

displayMessage()
{
	self endon( "disconnect" );

	number = getDvarInt( "welcome_player" ) + 1;
	setDvar( "welcome_player", number );

	self iPrintlnBold( "Hello " + self.name );
	wait 0.5;
	self iPrintlnBold( "You are our player number ^2" + number );
	wait 0.5;
	self iPrintlnBold( level.dvar["welcome_message1"] );
	self iPrintlnBold( level.dvar["welcome_message2"] );
}