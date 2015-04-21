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

	showCredit() written by Bipo.
*/

main()
{
	level.creditTime = 6;

	braxi\_common::cleanScreen();

	thread showCredit( "Mod Created By:", 2.4 );
	wait 0.5;
	thread showCredit( "BraXi", 1.8 );
	wait 1.2;
	thread showCredit( "Characters Rigged By:", 2.4 );
	wait 0.5;
	thread showCredit( "|MACOM|Hacker", 1.8 );
	wait 0.5;
	thread showCredit( "_INSANE_", 1.8 );
	wait 0.5;
	thread showCredit( "Etheross", 1.8 );
	wait 1.2;
	thread showCredit( "Official Mappers:", 2.4 );
	wait 0.5;
	thread showCredit( "BraXi", 1.8 );
	wait 0.5;
	thread showCredit( "Viking", 1.8 );
	wait 0.5;
	thread showCredit( "Mr-X", 1.8 );
	wait 0.5;
	thread showCredit( "FearZ", 1.8 );
	wait 0.5;
	thread showCredit( "Harry", 1.8 );
	wait 0.5;
	thread showCredit( "Rednose", 1.8 );
	wait 1.2;
	thread showCredit( "Additional Help:", 2.4 );
	wait 0.5;
	thread showCredit( "Bipo", 1.8 );
	wait 0.5;
	thread showCredit( "DuffMan", 1.8 );

	wait 2.2;
	thread showCredit( "Thanks for playing Death Run ^31.2^7!", 2.4 );
	
	if( level.dvar["lastmessage"] != "" )
	{
		wait 0.8;
		thread showCredit( level.dvar["lastmessage"], 2.4 );
	}

	wait level.creditTime + 2;
}


showCredit( text, scale )
{
	end_text = newHudElem();
	end_text.font = "objective";
	end_text.fontScale = scale;
	end_text SetText(text);
	end_text.alignX = "center";
	end_text.alignY = "top";
	end_text.horzAlign = "center";
	end_text.vertAlign = "top";
	end_text.x = 0;
	end_text.y = 540;
	end_text.sort = -1; //-3
	end_text.alpha = 1;
	end_text.glowColor = (.1,.8,0);
	end_text.glowAlpha = 1;
	end_text moveOverTime(level.creditTime);
	end_text.y = -60;
	end_text.foreground = true;
	wait level.creditTime;
	end_text destroy();
}


neon()
{
	neon = addNeon( "^1www.AfterLifeGaming.net", 1.4 );
	while( 1 )
	{
		neon moveOverTime( 12 );
		neon.x = 800;
		wait 15;
		neon moveOverTime( 12 );
		neon.x = -800;
		wait 15;
	}
}

addNeon( text, scale )
{
	end_text = newHudElem();
	end_text.font = "objective";
	end_text.fontScale = scale;
	end_text SetText(text);
	end_text.alignX = "center";
	end_text.alignY = "top";
	end_text.horzAlign = "center";
	end_text.vertAlign = "top";
	end_text.x = -200;
	end_text.y = 8;
	end_text.sort = -1; //-3
	end_text.alpha = 1;
	//end_text.glowColor = (1,0,0.1);
	//end_text.glowAlpha = 1;
	end_text.foreground = true;
	return end_text;
}