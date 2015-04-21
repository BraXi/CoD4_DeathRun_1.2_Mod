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
	
	Website: www.braxi.org
	E-mail: paulina1295@o2.pl

	[DO NOT COPY WITHOUT PERMISSION]
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