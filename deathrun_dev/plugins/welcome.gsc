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

init( modVersion )
{
	braxi\_dvar::addDvar( "welcome_message1", "welcome_message1", "Welcome to Death Run", "", "", "string" );
	braxi\_dvar::addDvar( "welcome_message2", "welcome_message2", "Have fun", "", "", "string" );

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