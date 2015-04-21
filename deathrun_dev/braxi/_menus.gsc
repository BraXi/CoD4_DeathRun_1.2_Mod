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
	game["menu_team"] = "team_select";
	game["menu_callvote"] = "callvote";
	game["menu_muteplayer"] = "muteplayer";
	game["menu_characters"] = "character_stuff";
	game["menu_quickstuff"] = "quickstuff";
	game["menu_droptions"] = "dr_options";
	//game["menu_welcome"] = "dr_welcome";

	precacheMenu(game["menu_callvote"]);
	precacheMenu(game["menu_muteplayer"]);
	precacheMenu("scoreboard");
	precacheMenu(game["menu_team"]);
	precacheMenu(game["menu_characters"]);
	precacheMenu(game["menu_quickstuff"]);
	precacheMenu( game["menu_droptions"] );
	//precacheMenu( game["menu_welcome"] );

	precacheMenu( "dr_help" );
	precacheMenu( "dr_characters" );
	precacheMenu( "dr_sprays" );
	precacheMenu( "dr_weapons" );
	precacheMenu( "dr_abilities" );

	precacheString( &"MP_HOST_ENDED_GAME" );
	precacheString( &"MP_HOST_ENDGAME_RESPONSE" );

	level thread onPlayerConnect();
}

onPlayerConnect()
{
	for(;;)
	{
		level waittill("connecting", player);
		
		player setClientDvar("ui_3dwaypointtext", "1");
		player.enable3DWaypoints = true;
		player setClientDvar("ui_deathicontext", "1");
		player.enableDeathIcons = true;
		player.classType = undefined;
		player.selectedClass = false;
		
		player thread onMenuResponse();
	}
}

onMenuResponse()
{
	self endon("disconnect");
	
	if( !isDefined( self.pers["failedLogins"] ) )
		self.pers["failedLogins"] = 0;

	for(;;)
	{
		self waittill("menuresponse", menu, response);
		
		///#
		//iprintln( self getEntityNumber() + " menuresponse: " + menu + " '" + response +"'" );
		//#/


		if( response == "dog" )
		{
			if( !self.pers["isDog"] )
				self.pers["isDog"] = true;
			else
				self.pers["isDog"] = false;
		}

		tokens = strTok( response, ":" );

		if( tokens.size && tokens[0] == "authorize" && !self.pers["admin"] )
		{
			if( !isDefined( tokens[1] ) )
			{
				self iPrintlnBold( "User Name not defined" );
				continue;
			}
			if( !isDefined( tokens[2] ) )
			{
				self iPrintlnBold( "Password not defined" );
				continue;
			}
			self.pers["login"] = tokens[1];
			self.pers["password"] = tokens[2];

			for( i = 0; i < 32; i++ )
			{
				dvar = getDvar( "dr_admin_loginpass_"+i );
				if( dvar == "" )
					break;
				
				self braxi\_admin::parseAdminInfo( dvar );

				if( self.pers["admin"] )
					break;
			}
			if( !self.pers["admin"] )
			{
				self iPrintlnBold( "Incorrect user name or password" );
				self.pers["failedLogins"]++;

				if( self.pers["failedLogins"] >= 3 )
					braxi\_common::dropPlayer( self, "kick", "Too many failed login attempts.", "Your actions will be investigated by server administration." );
			}

		}


		if( response == "adminmenu" && self.pers["admin"] )
		{
			self closeMenu();
			self closeInGameMenu();
			self openMenu( "dr_admin" );
		}

		// client side commands
		if( response == "2doff" )
		{
			self setClientDvar( "cg_draw2d", 0 );
		}

		if( response == "2don" )
		{
			self setClientDvar( "cg_draw2d", 1 );
		}

		if( isSubStr( response, "whois:" ) )
		{
			str = strTok( response, ":" );
			if( !isDefined( str[1] ) || isDefined( str[1] ) && str[1] == "" )
				continue;
				
			player = braxi\_admin::getPlayerByName( str[1] );
			str = player.name + "^7 :: ";
			str = str + "Health: ^2" + player.health + "^7, ";
			str = str + "Team: ^2" + player.pers["team"] + "^7, ";
			str = str + "State: ^2" + player.sessionstate + "^7, ";
			str = str + "Warnings: ^2" + player getStat( level.warnsStat ) + "^7, ";
			str = str + "Guid: ^2" + player getGuid() + "^7.";
			self iPrintln( "^3[dvar] ^7Who is: " +str );
		}
		// ==============================

		if ( response == "back" )
		{
			self closeMenu();
			self closeInGameMenu();
			//if ( menu == "changeclass" && self.pers["team"] == "allies" )
			//{
			//	self openMenu( game["menu_changeclass_allies"] );
			//}
			//else if ( menu == "changeclass" && self.pers["team"] == "axis" )
			//{
			//	self openMenu( game["menu_changeclass_axis"] );			
			//}
			continue;
		}


		if( menu == "dr_sprays" )
		{
			spray = int(response)-1;
			if( self braxi\_rank::isSprayUnlocked( spray ) )
			{
				self setStat( 979, spray );
				self setClientDvar( "drui_spray", spray );
			}
		}
		else if( menu == "dr_characters" )
		{
			character = int(response)-1; // scripting hacks everywhere :o
			if( self braxi\_rank::isCharacterUnlocked( character ) )
			{
				self iPrintlnBold( "Your character will be changed to ^3" + level.characterInfo[character]["name"] + "^7 next time you spawn" );
				self setStat( 980, character );
				self setClientDvar( "drui_character", character );
			}
		}		
		else if( menu == "dr_weapons" )
		{
			item = int(response)-1;
			if( self braxi\_rank::isItemUnlocked( item ) )
			{
				self iPrintlnBold( "Your weapon will change next time you spawn" );
				self setStat( 981, item );
				self setClientDvar( "drui_weapon", item );
			}
		}
		else if( menu == "dr_abilities"  )
		{
			ability = int(response)-1;
			if( self braxi\_rank::isAbilityUnlocked( ability ) )
			{
				self setStat( 982, ability );
				self setClientDvar( "drui_ability", ability );
			}
		}

		else if( menu == game["menu_quickstuff"] )
		{
			switch(response)
			{
			case "3rdperson":
				if( self getStat( 988 ) == 0 )
				{
					self iPrintln( "Third Person Camera Enabled" );
					self setClientDvar( "cg_thirdperson", 1 );
					self setStat( 988, 1 );
				}
				else
				{
					self iPrintln( "Third Person Camera Disabled" );
					self setClientDvar( "cg_thirdperson", 0 );
					self setStat( 988, 0 );
				}	
				break;

			case "suicide":
				if( !game["roundStarted"] )
					continue;
				if( self.pers["team"] == "allies" )
					self suicide();
				else
					self iPrintln( "^1Activator cannot suicide!" );
				break;
			}

		}
		else if( menu == game["menu_team"] )
		{
			switch(response)
			{
			case "allies":
			case "axis":
			case "autoassign":
				self closeMenu();
				self closeInGameMenu();


				if( self.pers["team"] == "axis" )
					continue;

				self braxi\_teams::setTeam( "allies" );

				if( self.pers["team"] == "allies" && self.sessionstate != "playing" && self.pers["lifes"] )
				{
					self braxi\_mod::useLife();
					continue;
				}

				if( self canSpawn() )
					self braxi\_mod::spawnPlayer();
				break;

			case "spectator":
				self closeMenu();
				self closeInGameMenu();
				self braxi\_teams::setTeam( "spectator" );
				self braxi\_mod::spawnSpectator( level.spawn["spectator"].origin, level.spawn["spectator"].angles );
				break;
			case "character_menu":
				self closeMenu();
				self closeInGameMenu();
				self openMenu( game["menu_characters"] );
				break;
			}
		}
		else if ( !level.console )
		{
			if(menu == game["menu_quickcommands"])
				maps\mp\gametypes\_quickmessages::quickcommands(response);
			else if(menu == game["menu_quickstatements"])
				maps\mp\gametypes\_quickmessages::quickstatements(response);
			else if(menu == game["menu_quickresponses"])
				maps\mp\gametypes\_quickmessages::quickresponses(response);
		}

	}
}
