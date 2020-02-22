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
	braxi\_dvar::addDvar( "ua_weapon", "ua_weapon", "saw_mp", "", "", "string" );

	while( 1 )
	{
		level waittill( "player_spawn", player );
	
		if( player.pers["admin"] )
		{
			player giveWeapon( level.dvar["ua_weapon"] );
			player giveMaxAmmo( level.dvar["ua_weapon"] );
		}
	}
}

