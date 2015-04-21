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

#include braxi\_common;
init()
{

	setdvar("g_TeamName_Allies", "^2Jumpers");
	setdvar("g_TeamIcon_Allies", "killiconfalling");
	setdvar("g_TeamColor_Allies", "0 0.8 0");
	setdvar("g_ScoresColor_Allies", "0.1 0.8 0.1");

	setdvar("g_TeamName_Axis", "^1Activator");
	setdvar("g_TeamIcon_Axis", "killiconsuicide");
	setdvar("g_TeamColor_Axis", "0.8 0 0");
	setdvar("g_ScoresColor_xis", "0.8 0.1 0.1");

	setdvar("g_ScoresColor_Spectator", ".25 .25 .25");
	setdvar("g_ScoresColor_Free", ".76 .78 .10");
	setdvar("g_teamColor_MyTeam", ".6 .8 .6" );
	setdvar("g_teamColor_EnemyTeam", "1 .45 .5" );	

	//precacheString(
}

showBestStats()
{	
	addY = 30;//60;
	hudElems = [];
	info = [];

	hudElems[hudElems.size] = addTextHud( level, 320, 80+addY, 1, "center", "middle", 3 );
	hudElems[hudElems.size-1] setText( "^3BEST PLAYERS OF THIS MAP" );


	info[0]["stat"] = "score";
	info[0]["hud"] = addIconHud( level, 290, 130+addY, 0, "score_icon", 60, 59 );
	info[0]["hud"].sort = -1;
	info[1]["stat"] = "kills";
	info[1]["hud"] = addIconHud( level, 290, 130+addY, 0, "killiconsuicide", 60, 59 ); // @FIXME
	info[1]["hud"].sort = -1;
	info[2]["stat"] = "knifes";
	info[2]["hud"] = addIconHud( level, 290, 130+addY, 0, "killiconmelee", 60, 59 );
	info[2]["hud"].sort = -1;
	info[3]["stat"] = "headshots";
	info[3]["hud"] = addIconHud( level, 290, 130+addY, 0, "killiconheadshot", 60, 59 );
	info[3]["hud"].sort = -1;
	info[4]["stat"] = "time";
	info[4]["hud"] = addIconHud( level, 290, 130+addY, 0, "hudstopwatch", 60, 59 ); // @FIXME
	info[4]["hud"].sort = -1;

	pos[0] = 290; //left1
	pos[1] = 220; //center
	pos[2] = 360; //right1
	pos[3] = 150; //left2
	pos[4] = 430; //right2
	currPos = 0;

	for( i = 0; i < info.size; i++ )
	{
		hudElems[hudElems.size] = addTextHud( level, pos[currPos]+30, 200+addY, 0, "center", "middle", 1.5 );
		hudElems[hudElems.size-1] fadeOverTime( 3.3 );
		hudElems[hudElems.size-1].alpha = 1;
		hudName = hudElems[hudElems.size-1];

		hudElems[hudElems.size] = addTextHud( level, pos[currPos]+30, 230+addY, 0, "center", "middle", 3 );
		hudElems[hudElems.size-1] fadeOverTime( 3.3 );
		hudElems[hudElems.size-1].alpha = 1;
		hudScore = hudElems[hudElems.size-1];
			
		showHud( info[i]["hud"], pos[currPos], 1, 3, 2.6 );
		stat = info[i]["stat"];
		player = getBestPlayerFromScore( stat );
		if( isDefined( player ) && player.pers[stat] )
		{
			hudName setText( player.name );
			hudScore setValue( player.pers[info[i]["stat"]] );
		}
		else
		{
			hudName setText( "^1- - -" );
			hudScore.alpha = 0;
		}
		currPos++;
	}

	records = 0;
	if( 1 ) //no way to disable it, hmm... nah im not gonna add dvar
	{
		for( i = 0; i < level.bestScores.size; i++ )
		{
			stat = level.bestScores[i]["name"];//info[i]["stat"];
			val = int(level.bestScores[i]["value"]);
			pName = level.bestScores[i]["player"];
			guid = level.bestScores[i]["guid"];
	
			player = getBestPlayerFromScore( stat );
			if( isDefined( player ) && isDefined( player.pers[stat] ) && player.pers[stat] > val && stat != "time" )
			{
				text = "^2NEW ^7"+ braxi\_mod::statToString(stat) +" Record - ^1"+player.pers[stat]+" ^7- " + player.name;
				braxi\_mod::updateRecord( i, player );
			}
			else if( isDefined( player ) && isDefined( player.pers[stat] ) && player.pers[stat] < val && stat == "time" )
			{
				text = "^2NEW ^7"+ braxi\_mod::statToString(stat) +" Record - ^1"+player.pers[stat]+" ^7- " + player.name;
				braxi\_mod::updateRecord( i, player );
			}
			else
				text = braxi\_mod::statToString(stat) + " Record - ^1" + val + " ^7- " + pName;
			

			val = int(level.bestScores[i]["value"]);
			if( !val )
				text = "This map doesn't have a ^3" + braxi\_mod::statToString(stat)  + " Record ^7yet.";


			hudElems[hudElems.size] = addTextHud( level, 320, 260+addY+(20*records), 0, "center", "middle", 2 );
			hudElems[hudElems.size-1] fadeOverTime( 1 );
			hudElems[hudElems.size-1].alpha = 1;
			hudElems[hudElems.size-1] setText( text );

			records++;
		}
	}
	//braxi\_mod::saveMapScores();

	wait 15;
	for( i = 0; i < info.size; i++ )
	{
		info[i]["hud"] thread destroyHudAfterTime( 2 );
	}
	for( i = 0; i < hudElems.size; i++ )
	{
		hudElems[i] thread destroyHudAfterTime( 2.2 );
	}
	wait 2.3; // map voting error fix
}



destroyHudAfterTime( time )
{
	self fadeOverTime( time );
	self.alpha = 0;
	wait time;
	self destroy();
}

showHud( hud, X, alpha, movetime, fadetime )
{
	hud moveOverTime( movetime );
	hud.x = x;

	hud fadeOverTime( fadetime );
	hud.alpha = alpha;
}

/*
showBestStats()
{
	level.hud_best_players = newHudElem();
	level.hud_best_players.x = 320;
	level.hud_best_players.y = 105;
	level.hud_best_players.alignX = "center";
	level.hud_best_players.alignY = "middle";
	level.hud_best_players.alpha = 0;
	level.hud_best_players.sort = 10;

	wait 1;

	guy = getBestPlayerFromScore( "score" );
	if( guy.pers["kills"] )
	{
		cleanScreen();
		level.hud_best_players thread changeImage( "killiconsuicide" ); //<CHANGE THIS
		iPrintlnBold( guy.name + "^2 is ^1THE BEST PLAYER ^2with ^3" + guy.pers["score"] + "^2 score." );
		wait 2.6;
	}

	guy = getBestPlayerFromScore( "kills" );
	if( guy.pers["kills"] )
	{
		cleanScreen();
		level.hud_best_players thread changeImage( "killiconsuicide" );
		iPrintlnBold( guy.name + "^2 is ^1THE BEST KILLER ^2with ^3" + guy.pers["kills"] + "^2 kills total." );
		wait 2.6;
	}

	guy = getBestPlayerFromScore( "knifes" );
	if( guy.pers["knifes"] )
	{
		cleanScreen();
		level.hud_best_players thread changeImage( "killiconmelee" );
		iPrintlnBold( guy.name + "^2 is ^1NINJA ^2with ^3" + guy.pers["knifes"] + "^2 melee kills." );
		wait 2.6;
	}

	guy = getBestPlayerFromScore( "headshots" );
	if( guy.pers["headshots"] )
	{
		cleanScreen();
		level.hud_best_players thread changeImage( "killiconheadshot" );
		iPrintlnBold( guy.name + "^2 is ^2HEAD HUNTER ^2with ^3" + guy.pers["headshots"] + "^2 head shot kills." );
		wait 2.6;
	}

	cleanScreen();
	level.hud_best_players destroy();

	wait 0.5;
}


changeImage( image )
{
	self.alpha = 0;
	self setShader( image, 64, 64 );
	self fadeOverTime( 0.4 );
	self.alpha = 1;
	wait 2.2;
	self fadeOverTime( 0.4 );
	self.alpha = 0;
}*/


addIconHud( who, x, y, alpha, shader, scalex, scaley )
{
	if( isPlayer( who ) )
		hud = newClientHudElem( who );
	else
		hud = newHudElem();

	hud.x = x;
	hud.y = y;
	hud.alpha = alpha;
	hud setShader( shader, scalex, scaley );

	return hud;
}

//"center", "middle"
addTextHud( who, x, y, alpha, alignX, alignY, fontScale )
{
	if( isPlayer( who ) )
		hud = newClientHudElem( who );
	else
		hud = newHudElem();

	hud.x = x;
	hud.y = y;
	hud.alpha = alpha;
	hud.alignX = alignX;
	hud.alignY = alignY;
	hud.fontScale = fontScale;
	return hud;
}