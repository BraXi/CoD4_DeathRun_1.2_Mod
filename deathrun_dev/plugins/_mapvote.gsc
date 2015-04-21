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
//	Zombie Mod by BraXi v1.2
//
//	Xfire: braxpl
//	Web: www.braxi.webatu.com
//

main()
{
	level.gametype = getDvar("g_gametype");
	level.logging = getDvarInt("logfile");


	if( !level.dvar["mapVote"] )
		return;

	// Setup strings
	game["MapVote"]	= &"Press ^2FIRE^7 to vote";
	game["TimeLeft"] = &"Time Left: ";
	game["MapVoteHeader"] = &"Vote for the next map";

	// Precache stuff used by map voting
	precacheShader("white");
	precacheString(game["MapVote"]);
	precacheString(game["TimeLeft"]);
	precacheString(game["MapVoteHeader"]);
}

Initialize()
{
	if( !level.dvar["mapVote"] )
		return false;

	level.mapvotehudoffset = 100;

	// Small wait
	wait .5;

	//CleanUp();

	CreateHud();

	thread RunMapVote();

	level waittill( "VotingComplete" );

	// Delete HUD
	DeleteHud();
}

CleanUp()
{
	// Kill AWE threads
	level notify("awe_killthreads");
	// Wait for threads to die
	wait .05;
	// Delete some HUD elements
	if(isdefined(level.clock)) level.clock destroy();
}

CreateHud()
{
	level.vote_hud_bgnd = newHudElem();
	level.vote_hud_bgnd.archived = false;
	level.vote_hud_bgnd.alpha = .7;
	level.vote_hud_bgnd.x = 205;
	level.vote_hud_bgnd.y = level.mapvotehudoffset + 17;
	level.vote_hud_bgnd.sort = 9000;
	level.vote_hud_bgnd.color = (0,0,0);
	level.vote_hud_bgnd setShader("white", 260, 140);
	
	level.vote_header = newHudElem();
	level.vote_header.archived = false;
	level.vote_header.alpha = .3;
	level.vote_header.x = 208;
	level.vote_header.y = level.mapvotehudoffset + 19;
	level.vote_header.sort = 9001;
	level.vote_header setShader("white", 254, 21);
	
	level.vote_headerText = newHudElem();
	level.vote_headerText.archived = false;
	level.vote_headerText.x = 210;
	level.vote_headerText.y = level.mapvotehudoffset + 21;
	level.vote_headerText.sort = 9998;
	level.vote_headerText.label = game["MapVoteHeader"];
	level.vote_headerText.fontscale = 1.8;

	level.vote_leftline = newHudElem();
	level.vote_leftline.archived = false;
	level.vote_leftline.alpha = .3;
	level.vote_leftline.x = 207;
	level.vote_leftline.y = level.mapvotehudoffset + 19;
	level.vote_leftline.sort = 9001;
	level.vote_leftline setShader("white", 1, 135);
	
	level.vote_rightline = newHudElem();
	level.vote_rightline.archived = false;
	level.vote_rightline.alpha = .3;
	level.vote_rightline.x = 462;
	level.vote_rightline.y = level.mapvotehudoffset + 19;
	level.vote_rightline.sort = 9001;
	level.vote_rightline setShader("white", 1, 135);
	
	level.vote_bottomline = newHudElem();
	level.vote_bottomline.archived = false;
	level.vote_bottomline.alpha = .3;
	level.vote_bottomline.x = 207;
	level.vote_bottomline.y = level.mapvotehudoffset + 154;
	level.vote_bottomline.sort = 9001;
	level.vote_bottomline setShader("white", 256, 1);

	level.vote_hud_timeleft = newHudElem();
	level.vote_hud_timeleft.archived = false;
	level.vote_hud_timeleft.x = 385;
	level.vote_hud_timeleft.y = level.mapvotehudoffset + 26;
	level.vote_hud_timeleft.sort = 9998;
	level.vote_hud_timeleft.fontscale = 1.4;
	level.vote_hud_timeleft.label = game["TimeLeft"];
	level.vote_hud_timeleft setValue( level.dvar["mapVoteTime"] );	
	
	level.vote_hud_instructions = newHudElem();
	level.vote_hud_instructions.archived = false;
	level.vote_hud_instructions.x = 320;
	level.vote_hud_instructions.y = level.mapvotehudoffset + 56;
	level.vote_hud_instructions.sort = 9998;
	level.vote_hud_instructions.fontscale = 1.4;
	level.vote_hud_instructions.label = game["MapVote"];
	level.vote_hud_instructions.alignX = "center";
	level.vote_hud_instructions.alignY = "middle";
	
	level.vote_map = [];

	level.numMapsInVote = 6;

	for( i = 0; i < level.numMapsInVote; i++ )
	{
		level.vote_map[i] = newHudElem();
		level.vote_map[i].archived = false;
		level.vote_map[i].x = 320;
		level.vote_map[i].y = level.mapvotehudoffset + 69 + (i*16);
		level.vote_map[i].alignX = "center";
		level.vote_map[i].sort = 9998;
		level.vote_map[i].fontscale = 1.4;
	}
}


RunMapVote()
{
	maps = undefined;
	x = undefined;

	currentmap = getDvar("mapname");
	currentgt = level.gametype;
 
	x = GetRandomMapRotation();
	if(isdefined(x))
	{
		if(isdefined(level.maps_in_vote))
			maps = level.maps_in_vote;
	}

	// Any maps?
	if(!isdefined(maps))
	{
		wait 0.05;
		level notify("VotingComplete");
		return;
	}

	// Fill all alternatives with the current map in case there is not enough unique maps
	for(j=0;j<level.numMapsInVote;j++)
	{
		level.mapcandidate[j]["map"] = currentmap;
		level.mapcandidate[j]["mapname"] = "Replay this map";
		level.mapcandidate[j]["gametype"] = currentgt;
		level.mapcandidate[j]["votes"] = 0;
	}
	
	//get candidates
	i = 0;
	for(j=0;j<level.numMapsInVote;j++)
	{
		// Skip current map and gametype combination
		if(maps[i]["map"] == currentmap && maps[i]["gametype"] == level.gametype)
			i++;

		// Any maps left?
		if(!isdefined(maps[i]))
			break;

		level.mapcandidate[j]["map"] = maps[i]["map"];
		level.mapcandidate[j]["mapname"] = getMapName(maps[i]["map"]);
		level.mapcandidate[j]["gametype"] = "deathrun"; //maps[i]["gametype"];
		level.mapcandidate[j]["votes"] = 0;

		i++;

		// Any maps left?
		if(!isdefined(maps[i]))
			break;

		// Keep current map as last alternative?
		if(level.dvar["mapVoteReplay"] && j>2)
			break;
	}
	
	thread DisplayMapChoices();
	
	game["menu_team"] = "";

	//start a voting thread per player
	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
		players[i] thread PlayerVote();
	
	thread VoteLogic();
	
	//Take a breath for players to restart with the map
	wait 0.1;	
	level.mapended = true;	
}

DeleteHud()
{
	level.vote_headerText destroy();
	level.vote_hud_timeleft destroy();	
	level.vote_hud_instructions destroy();

	for( i = 0; i < level.vote_map.size; i++ )
		level.vote_map[i] destroy();

	level.vote_hud_bgnd destroy();
	level.vote_header destroy();
	level.vote_leftline destroy();
	level.vote_rightline destroy();
	level.vote_bottomline destroy();

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
		if(isdefined(players[i].vote_indicator))
			players[i].vote_indicator destroy();
}

//Displays the map candidates
DisplayMapChoices()
{
	for( i = 0; i < level.vote_map.size; i++ )
	{
		level.vote_map[i].alpha = 1;
		level.vote_map[i] setText( level.mapcandidate[i]["mapname"] );
	}

	level endon("VotingDone");
	/*for(;;)
	{
		for( i = 0; i < level.vote_map.size; i++ )
				level.vote_map[i] setText
		wait 7.8;
	}*/	
}

/*
DisplayMapChoices()
{
	level endon("VotingDone");
	for(;;)
	{
		iprintlnbold(level.mapcandidate[0]["mapname"] + " (" + level.mapcandidate[0]["gametype"] +")");
		iprintlnbold(level.mapcandidate[1]["mapname"] + " (" + level.mapcandidate[1]["gametype"] +")");
		iprintlnbold(level.mapcandidate[2]["mapname"] + " (" + level.mapcandidate[2]["gametype"] +")");
		iprintlnbold(level.mapcandidate[3]["mapname"] + " (" + level.mapcandidate[3]["gametype"] +")");
		iprintlnbold(level.mapcandidate[4]["mapname"] + " (" + level.mapcandidate[4]["gametype"] +")");
		wait 7.8;
	}	
}
*/
//Changes the players vote as he hits the attack button and updates HUD
PlayerVote()
{
	level endon("VotingDone");
	self endon("disconnect");

	novote = false;
	
	// No voting for spectators
	//if(self.pers["team"] == "spectator") //Prueba unicamente voto espectador
	//	novote = true;

	// Spawn player as spectator
	//self maps\mp\gametypes\zom::spawnSpectator();
	self.sessionstate = "spectator";
	self.spectatorclient = -1;
	resettimeout();
	
	//remove the scoreboard
	self setClientDvar("g_scriptMainMenu", "");
	self closeMenu();

	self allowSpectateTeam("allies", false);
	self allowSpectateTeam("axis", false);
	self allowSpectateTeam("freelook", false);
	self allowSpectateTeam("none", true);

	if(novote)
		return;

//	self.votechoice = 0;

	colors[0] = (0  ,  0,  1);
	colors[1] = (0  ,0.5,  1);
	colors[2] = (0  ,  1,  1);
	colors[3] = (0  ,  1,0.5);
	colors[4] = (0  ,  1,  0);
	colors[5] = (0.5,  1,  0);	
	colors[6] = (1  ,0.5,  0);
	colors[7] = (1  ,  1,  0);

	self.vote_indicator = newClientHudElem( self );
	self.vote_indicator.alignY = "middle";
	self.vote_indicator.x = 208;
	self.vote_indicator.y = level.mapvotehudoffset + 75;
	self.vote_indicator.archived = false;
	self.vote_indicator.sort = 9998;
	self.vote_indicator.alpha = 0;
	self.vote_indicator.color = colors[0];
	self.vote_indicator setShader("white", 254, 17);
	
	hasVoted = false;

	for (;;)
	{
		wait .01;
								
		if(self attackButtonPressed() == true)
		{
			// -- Added by Number7 --
			if(!hasVoted)
			{
				self.vote_indicator.alpha = .3;
				self.votechoice = 0;
				hasVoted = true;
			}
			else
				self.votechoice++;

			if (self.votechoice == 5)
				self.votechoice = 0;

//			self iprintln("You have voted for ^2" + level.mapcandidate[self.votechoice]["mapname"] + " (" + level.mapcandidate[self.votechoice]["gametype"]+")");
			self iprintln("You have voted for ^2" + level.mapcandidate[self.votechoice]["mapname"]);
			self.vote_indicator.y = level.mapvotehudoffset + 77 + self.votechoice * 16;			
			self.vote_indicator.color = colors[self.votechoice];

//			self playLocalSound("hq_score");
		}					
		while(self attackButtonPressed() == true)
			wait .05;

		self.sessionstate = "spectator";
		self.spectatorclient = -1;
	}
}

//Determines winning map and sets rotation
VoteLogic()
{
	//Vote Timer
	for(;level.dvar["mapVoteTime"]>=0;level.dvar["mapVoteTime"]--)
	{
		for(j=0;j<10;j++)
		{
			// Count votes
			for( i = 0; i < level.numMapsInVote; i++ )	
				level.mapcandidate[i]["votes"] = 0;

			players = getentarray("player", "classname");
			for(i = 0; i < players.size; i++)
				if(isdefined(players[i].votechoice))
					level.mapcandidate[players[i].votechoice]["votes"]++;

			// Update HUD
			for( i = 0; i < level.numMapsInVote; i++ )
			{
				level.vote_map[i].alpha = 1;
				//level.vote_map[i] setValue( level.mapcandidate[i]["votes"] );
				level.vote_map[i] setText( "^2"+ level.mapcandidate[i]["mapname"] + " ^3("+level.mapcandidate[i]["votes"]+")" );
			}
			wait .1;
		}
		level.vote_hud_timeleft setValue( level.dvar["mapVoteTime"] );
	}	

	wait 0.2;
	
	newmapnum = 0;
	topvotes = 0;
	for(i=0;i<level.numMapsInVote;i++)
	{
		if (level.mapcandidate[i]["votes"] > topvotes)
		{
			newmapnum = i;
			topvotes = level.mapcandidate[i]["votes"];
		}
	}

	SetMapWinner(newmapnum);
}

//change the map rotation to represent the current selection
SetMapWinner(winner)
{
	map	= level.mapcandidate[winner]["map"];
	mapname	= level.mapcandidate[winner]["mapname"];
	gametype = level.mapcandidate[winner]["gametype"];

	setDvar("sv_maprotationcurrent", " gametype " + gametype + " map " + map);

	wait 0.1;

	// Stop threads
	level notify( "VotingDone" );

	// Wait for threads to die
	wait 0.05;

	// Announce winner
	iprintlnbold(" ");
	iprintlnbold(" ");
	iprintlnbold(" ");
	iprintlnbold(" ");
	iprintlnbold("Next map will be: ^2"+mapname);
	//iprintlnbold("^2" + mapname);
//	iprintlnbold("^2" + GetGametypeName(gametype));

	// Fade HUD elements
	level.vote_headerText fadeOverTime (1);
	level.vote_hud_timeleft fadeOverTime (1);	
	level.vote_hud_instructions fadeOverTime (1);
	level.vote_map[0] fadeOverTime (1);
	level.vote_map[1] fadeOverTime (1);
	level.vote_map[2] fadeOverTime (1);
	level.vote_map[3] fadeOverTime (1);
	level.vote_map[4] fadeOverTime (1);
	level.vote_hud_bgnd fadeOverTime (1);
	level.vote_header fadeOverTime (1);
	level.vote_leftline fadeOverTime (1);
	level.vote_rightline fadeOverTime (1);
	level.vote_bottomline fadeOverTime (1);

	level.vote_headerText.alpha = 0;
	level.vote_hud_timeleft.alpha = 0;	
	level.vote_hud_instructions.alpha = 0;
	level.vote_map[0].alpha = 0;
	level.vote_map[1].alpha = 0;
	level.vote_map[2].alpha = 0;
	level.vote_map[3].alpha = 0;
	level.vote_map[4].alpha = 0;
	level.vote_hud_bgnd.alpha = 0;
	level.vote_header.alpha = 0;
	level.vote_leftline.alpha = 0;
	level.vote_rightline.alpha = 0;
	level.vote_bottomline.alpha = 0;

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		if(isdefined(players[i].vote_indicator))
		{
			players[i].vote_indicator fadeOverTime (1);
			players[i].vote_indicator.alpha = 0;
		}
	}

	// Show winning map for a few seconds
	wait 4;
	level notify( "VotingComplete" );
}

GetRandomMapRotation(random, current, number)
{
	maprot = strip(getDvar("sv_maprotation"));

	if(!isdefined(number))
		number = 0;

	// No map rotation setup!
	if(maprot == "")
		return undefined;
	
	// Explode entries into an array
	j=0;
	temparr2[j] = "";	
	for(i=0;i<maprot.size;i++)
	{
		if(maprot[i]==" ")
		{
			j++;
			temparr2[j] = "";
		}
		else
			temparr2[j] += maprot[i];
	}

	// Remove empty elements (double spaces)
	temparr = [];
	for(i=0;i<temparr2.size;i++)
	{
		element = strip(temparr2[i]);
		if(element != "")
			temparr[temparr.size] = element;
	}

	level.maps_in_vote = [];
	lastgt = level.gametype;
	for(i=0;i<temparr.size;)
	{
		switch(temparr[i])
		{
			case "gametype":
				if(isdefined(temparr[i+1]))
					lastgt = temparr[i+1];
				i += 2;
				break;

			case "map":
				if(isdefined(temparr[i+1]))
				{
					level.maps_in_vote[level.maps_in_vote.size]["gametype"]	= lastgt;
					level.maps_in_vote[level.maps_in_vote.size-1]["map"] = temparr[i+1];
				}

				i += 2;
				break;

			// If code get here, then the maprotation is corrupt so we have to fix it
			default:
				iprintlnbold("Warning: Error detected in map rotation");
	
				if(isGametype(temparr[i]))
					lastgt = temparr[i];
				else
				{
					level.maps_in_vote[level.maps_in_vote.size]["gametype"]	= lastgt;
					level.maps_in_vote[level.maps_in_vote.size-1]["map"] = temparr[i];
				}
					

				i += 1;
				break;
		}
		if(number && level.maps_in_vote.size >= number)
			break;
	}

	// Shuffle the array 20 times
	for(k = 0; k < 20; k++)
	{
		for(i = 0; i < level.maps_in_vote.size; i++)
		{
			j = randomInt(level.maps_in_vote.size);
			element = level.maps_in_vote[i];
			level.maps_in_vote[i] = level.maps_in_vote[j];
			level.maps_in_vote[j] = element;
		}
	}

	return level.maps_in_vote;
}

// Strip blanks at start and end of string
strip(s)
{
	if(s=="")
		return "";

	s2="";
	s3="";

	i=0;
	while(i<s.size && s[i]==" ")
		i++;

	// String is just blanks?
	if(i==s.size)
		return "";
	
	for(;i<s.size;i++)
	{
		s2 += s[i];
	}

	i=s2.size-1;
	while(s2[i]==" " && i>0)
		i--;

	for(j=0;j<=i;j++)
	{
		s3 += s2[j];
	}
		
	return s3;
}

isGametype(gt)
{
	switch(gt)
	{
		case "dm":
		case "tdm":
		case "sd":
		case "hq":
		case "re":
		case "bel":
		case "zom":	
		case "zombies":
		case "deathrun":	
			return true;

		default:
			return false;
	}
}
getMapName(map)
{
	switch(map)
	{
	case "mp_crash":
		mapname = "Crash";
		break;
	default:
		mapname = map;
		break;
	}

	return mapname;
}

getGametypeName(gt)
{
	switch(gt)
	{
		case "bel":
			gtname = "Behind Enemy Lines";
			break;

		case "dm":
			gtname = "Deathmatch";
			break;
		
		case "tdm":
			gtname = "Team Deathmatch";
			break;

		case "sd":
			gtname = "Search & Destroy";
			break;

		case "hq":
			gtname = "Headquarters";
			break;
	
		case "hq":
			gtname = "Death Run";
			break;

		case "zom":
		case "zombies":
			gtname = "^1Zombies^7";
			break;					

		default:
			gtname = gt;
			break;
	}

	return gtname;
}