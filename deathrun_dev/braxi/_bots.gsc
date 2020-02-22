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

	Fake clients, should not use for things other than testing stuff.
*/

addTestClients()
{
	if( isDefined( game["matchstarted"] ) )
		return;

	wait 2;
/*
	for(;;)
	{
		if(getDvarInt("scr_testclients") > 0)
			break;
		wait 1;
	}*/

	ent = [];
	testclients = level.dvar["bots"];
	for(i = 0; i < testclients+1; i++)
	{
		ent[i] = addTestClient();
		wait .05;
		if( isDefined( ent[i] ) )
			ent[i] thread TestClient();
		wait 0.5;
	}
}

TestClient()
{
	while(!isdefined(self.pers["team"]))
		wait .05;

//	level waittill( "game started" );
	wait 0.05;
	self notify( "menuresponse", game["menu_team"], "axis" );
//	wait 0.5;
}