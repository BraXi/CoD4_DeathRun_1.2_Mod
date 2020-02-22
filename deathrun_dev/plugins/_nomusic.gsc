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

// This plugin will force no music at round/game end

init( modVersion )
{
    thread onIntermission();

    level waittill( "round_ended" );
    ambientStop( 0 );
}

onIntermission()
{
    level waittill( "intermission" );
    ambientStop( 0 );
} 
