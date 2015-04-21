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


#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include braxi\_common;

init()
{
	if ( !mayProcessChallenges() )
		return;
	
	level.numChallengeTiers	= 2;

	level.ch_ownage = 0;
	level.ch_machines = 0;

	braxi\_rank::registerScoreInfo( "challenge", 250 );
	precacheString( &"MP_CHALLENGE_COMPLETED" );

	buildChallegeInfo();

	thread playerConnected();
	thread playerSpawned();
	thread playerKilled();
	thread playerDamaged();

	thread onEndRound();
	thread onEndMap();
}

mayProcessChallenges()
{
	return true;
}

onEndRound()
{
	level waittill( "round_ended", reasonText, winningTeam );

	players = getAllPlayers();
	for( i = 0; i < players.size; i++ )
	{
		if( !players[i] isReallyAlive() )
			continue;

		players[i] processChallenge( "ch_rounds1" );
	}

	if( !level.freeRun && level.ch_machines >= 6 && isDefined( level.activ ) && level.activ isReallyAlive() )
		level.activ processChallenge( "ch_machines" );
}

onEndMap()
{
	level waittill( "intermission" );
	
	player = getBestPlayerFromScore( "score" );
	if( isDefined( player ) && player.pers["score"] )
	{
		player processChallenge( "ch_risingstar" );
		player processChallenge( "ch_ontop", 1 );
	}
}

playerConnected()
{
	while( 1 )
	{
		level waittill( "connected", player );
		player thread onPlayerDisconnect();		
		player.ch_kills = 0;
		
		// hack
		player updateChallenges();
		player thread unlockChallenge( "tier_1" );
		player updateChallenges();

	}
}



onPlayerDisconnect()
{
	self waittill( "disconnect" );
	//some stuff here
}

test()
{
	while( self.sessionstate == "playing" )
	{
		while( !self useButtonPressed() )
			wait 0.5;

		
		self processChallenge( "ch_ontop", 1 );
		wait 1;
	}
}

playerSpawned()
{
	while( 1 )
	{
		level waittill( "player_spawn", player );
		player thread ch_spray();
		//player thread test();
	}
}

playerDamaged()
{
	while( 1 )
	{
		level waittill( "player_damage", who, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon );
	}
}

playerKilled()
{
	while( 1 )
	{
		level waittill( "player_killed", who, eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration ) ;

		if( !level.freeRun )
			who processChallenge( "ch_failzor", 1 );

		level.ch_machines += 1;

		if( isPlayer( attacker ) )
		{
			if( attacker == who || !isPlayer( attacker ) )
				return;

			
			if( attacker.pers["team"] == "axis" )
			{
				level.ch_machines = -999;
				level.ch_ownage++;
				
				if( level.ch_ownage == 3 )
					attacker processChallenge( "ch_ownage" );
			}
			else
			{
				if( isDefined( attacker.usedLife ) && who.pers["team"] == "axis" )
					attacker processChallenge( "ch_back" );
			}

			if( sHitLoc == "head" && sMeansOfDeath != "MOD_MELEE" )
			{
				sMeansOfDeath = "MOD_HEAD_SHOT";
				attacker processChallenge( "ch_headshot" );
			}
				

			if( !attacker isOnGround() && !who isOnGround() )
				attacker processChallenge( "ch_airkill" );


			if( sMeansOfDeath == "MOD_HEAD_SHOT" )
			{
				switch( sWeapon )
				{
					case "beretta_mp":
					case "colt_mp":
					case "usp_mp":
						w = strTok( sWeapon, "_" )[0];
						attacker processChallenge( "ch_" + w + "head" + 1 );
						break;						
				}
			}

			switch( sWeapon )
			{
				case "beretta_mp":
				case "colt_mp":
				case "usp_mp":
					w = strTok( sWeapon, "_" )[0];
					//for( i = 1; i < 4; i++ )
					//	attacker processChallenge( "ch_beretta"+i );

					attacker processChallenge( "ch_" + w + "1" );
					break;
				/*case "deserteagle_mp":
					attacker processChallenge( "ch_deserteagle1" );
					break;
				case "m40a3_mp":
					attacker processChallenge( "ch_m40a31" );
					break;	
				case "deserteaglegold_mp":
					attacker processChallenge( "ch_deserteaglegold1" );
					break;	
				case "remington700_mp":
					attacker processChallenge( "ch_remington7001" );
					break;	
				case "colt44_mp":
					attacker processChallenge( "ch_colt441" );
					break;*/		
						
				case "knife_mp":
				case "hands_mp":
				case "tomahawk_mp":
					attacker processChallenge( "ch_knifemaster1" );
					break;					
			}
			
		}
		else
		{
			
		}
	}
}


ch_spray()
{
	self endon( "disconnect" );
	self endon( "death" );

	wait 0.2;
	while( self.sessionstate == "playing" )
	{
		self waittill( "spray", sprayNum, sprayPos );

		ents = getEntArray( "dr_deadbody", "targetname" );
		for( i = 0; i < ents.size; i++ )
		{
			if( /*ents[i].model == "body_mp_usmc_cqb" &&*/ distance( ents[i].origin, sprayPos ) < 64 )
			{
				self processChallenge( "ch_spray" );
				break;
			}
		}
	}
}
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////

dumpTable( tableName )
{
		for( idx = 1; isdefined( tableLookup( tableName, 0, idx, 0 ) ) && tableLookup( tableName, 0, idx, 0 ) != ""; idx++ )
		{
			//a = [];
			string = "";
			for( i = 1; i < 16; i++ )
			{
				a = tableLookup( tableName, 0, idx, i );
				string = (string + a + ",");
			}
			logPrint( string+"\n" );
		}
}

buildChallegeInfo()
{
	level.challengeInfo = [];
	
	for ( i = 1; i <= level.numChallengeTiers; i++ )
	{
		tableName = "mp/challengetable_tier"+i+".csv";

		baseRef = "";
		// unlocks all the challenges in this tier
		for( idx = 1; isdefined( tableLookup( tableName, 0, idx, 0 ) ) && tableLookup( tableName, 0, idx, 0 ) != ""; idx++ )
		{
			stat_num = tableLookup( tableName, 0, idx, 2 );
			refString = tableLookup( tableName, 0, idx, 7 );

			level.challengeInfo[refString] = [];
			level.challengeInfo[refString]["tier"] = i;
			level.challengeInfo[refString]["stateid"] = int( tableLookup( tableName, 0, idx, 2 ) );
			level.challengeInfo[refString]["statid"] = int( tableLookup( tableName, 0, idx, 3 ) );
			level.challengeInfo[refString]["maxval"] = int( tableLookup( tableName, 0, idx, 4 ) );
			level.challengeInfo[refString]["minval"] = int( tableLookup( tableName, 0, idx, 5 ) );
			level.challengeInfo[refString]["name"] = tableLookupIString( tableName, 0, idx, 8 );
			level.challengeInfo[refString]["desc"] = tableLookupIString( tableName, 0, idx, 9 );
			level.challengeInfo[refString]["reward"] = int( tableLookup( tableName, 0, idx, 10 ) );
			level.challengeInfo[refString]["ability"] = tableLookup( tableName, 0, idx, 12 );			// ABILITY
			level.challengeInfo[refString]["character"] = tableLookup( tableName, 0, idx, 13 );	// CHARACTER
			level.challengeInfo[refString]["group"] = tableLookup( tableName, 0, idx, 14 );

			precacheString( level.challengeInfo[refString]["name"] );

			if ( !int( level.challengeInfo[refString]["stateid"] ) )
			{
				level.challengeInfo[baseRef]["levels"]++;
				level.challengeInfo[refString]["stateid"] = level.challengeInfo[baseRef]["stateid"];
				level.challengeInfo[refString]["level"] = level.challengeInfo[baseRef]["levels"];
			}
			else
			{
				level.challengeInfo[refString]["levels"] = 1;
				level.challengeInfo[refString]["level"] = 1;
				baseRef = refString;
			}
		}
	}
}

// update copy of a challenges to be progressed this game, only at the start of the game
// challenges unlocked during the game will not be progressed on during that game session
updateChallenges()
{
	self.challengeData = [];
	for ( i = 1; i <= level.numChallengeTiers; i++ )
	{
		tableName = "mp/challengetable_tier"+i+".csv";

		idx = 1;
		// unlocks all the challenges in this tier
		for( idx = 1; isdefined( tableLookup( tableName, 0, idx, 0 ) ) && tableLookup( tableName, 0, idx, 0 ) != ""; idx++ )
		{
			stat_num = tableLookup( tableName, 0, idx, 2 );
			if( isdefined( stat_num ) && stat_num != "" )
			{
				statVal = self getStat( int( stat_num ) );
				
				refString = tableLookup( tableName, 0, idx, 7 );
				if ( statVal )
					self.challengeData[refString] = statVal;
			}
		}
	}
}

unlockChallenge( refString )
{
	assert( isDefined( refString ) && refString != "" );

	// tokenize reference string, accepting multiple camo unlocks in one call
	Ref_Tok = strTok( refString, ";" );
	assertex( Ref_Tok.size > 0, "Camo unlock specified in datatable ["+refString+"] is incomplete or empty" );
	
	for( i=0; i<Ref_Tok.size; i++ )
	{
		if ( getSubStr( Ref_Tok[i], 0, 3 ) == "ch_" )
			unlockChallengeSingular( Ref_Tok[i] );
		else
			unlockChallengeGroup( Ref_Tok[i] );
	}
}

// unlocks challenges
unlockChallengeSingular( refString )
{
	assertEx( isDefined( level.challengeInfo[refString] ), "Challenge unlock "+refString+" does not exist." );
	tableName = "mp/challengetable_tier" + level.challengeInfo[refString]["tier"] + ".csv";
	
	if ( self getStat( level.challengeInfo[refString]["stateid"] ) )
		return;

	self setStat( level.challengeInfo[refString]["stateid"], 1 );
	self setStat( 269 + level.challengeInfo[refString]["tier"], 2 );// 2: new, 1: old
}

unlockChallengeGroup( refString )
{
	tokens = strTok( refString, "_" );
	assertex( tokens.size > 0, "Challenge unlock specified in datatable ["+refString+"] is incomplete or empty" );
	
	assert( tokens[0] == "tier" );
	
	tierId = int( tokens[1] );
	assertEx( tierId > 0 && tierId <= level.numChallengeTiers, "invalid tier ID " + tierId );

	groupId = "";
	if ( tokens.size > 2 )
		groupId = tokens[2];

	challengeArray = getArrayKeys( level.challengeInfo );
	
	for ( index = 0; index < challengeArray.size; index++ )
	{
		challenge = level.challengeInfo[challengeArray[index]];
		
		if ( challenge["tier"] != tierId )
			continue;		
		if ( challenge["group"] != groupId )
			continue;		
		if ( self getStat( challenge["stateid"] ) )
			continue;
	
		self setStat( challenge["stateid"], 1 );		
		self setStat( 269 + challenge["tier"], 2 );// 2: new, 1: old	
	}
}





getChallengeStatus( name )
{
//	return self getStat( int(tableLookup( statsTable, 7, name, 2 )) ); // too slow, instead we store the challenge status at the beginning of the game
	if ( isDefined( self.challengeData[name] ) )
		return self.challengeData[name];
	else
		return 0;
}

getChallengeLevels( baseName )
{
	if ( isDefined( level.challengeInfo[baseName] ) )
		return level.challengeInfo[baseName]["levels"];
		
	assertex( isDefined( level.challengeInfo[baseName + "1" ] ), "Challenge name " + baseName + " not found!" );
	
	if( isDefined( level.challengeInfo[baseName + "1"] ) )
		return level.challengeInfo[baseName + "1"]["levels"];
}

isStrStart( string1, subStr )
{
	return ( getSubStr( string1, 0, subStr.size ) == subStr );
}

processChallenge( baseName, progressInc )
{
	if ( !mayProcessChallenges() )
		return;
		
	numLevels = getChallengeLevels( baseName );
	
	if ( numLevels > 1 )
		missionStatus = self getChallengeStatus( (baseName + "1") );
	else
		missionStatus = self getChallengeStatus( baseName );

	if ( !isDefined( progressInc ) )
		progressInc = 1;
	
	///#
	//if ( getDvarInt( "debug_challenges" ) )
	//	println( "CHALLENGE PROGRESS - " + baseName + ": " + progressInc );
	//#/
	
	if ( !missionStatus || missionStatus == 255 )
		return;
		
	assertex( missionStatus <= numLevels, "Mini challenge levels higher than max: " + missionStatus + " vs. " + numLevels );
	
	if ( numLevels > 1 )
		refString = baseName + missionStatus;
	else
		refString = baseName;

	progress = self getStat( level.challengeInfo[refString]["statid"] );
	progress += progressInc;
	
	self setStat( level.challengeInfo[refString]["statid"], progress );

	if ( progress >= level.challengeInfo[refString]["maxval"] )
	{
		if( level.challengeInfo[refString]["ability"] != "" )
			self thread challengeNotify( level.challengeInfo[refString]["name"], "Unlocked new ability!" );
		else
			self thread challengeNotify( level.challengeInfo[refString]["name"], level.challengeInfo[refString]["desc"] );

		if ( missionStatus == numLevels )
			missionStatus = 255;
		else
			missionStatus += 1;

		if ( numLevels > 1 )
			self.challengeData[baseName + "1"] = missionStatus;
		else
			self.challengeData[baseName] = missionStatus;

		// prevent bars from running over
		self setStat( level.challengeInfo[refString]["statid"], level.challengeInfo[refString]["maxval"] );

		self setStat( level.challengeInfo[refString]["stateid"], missionStatus );
		self braxi\_rank::giveRankXP( "challenge", level.challengeInfo[refString]["reward"] );

		// hacks everywhere...
		if( self tierCheck( level.challengeInfo[refString]["id"] ) )
		{
			if( level.challengeInfo[refString]["id"] == 1 )
			{
				self thread unlockChallenge( "tier_2" );
				self updateChallenges();
			}
		}

		if( level.challengeInfo[refString]["ability"] != "" )
			self braxi\_rank::unlockAbility( level.challengeInfo[refString]["ability"] );
	}
}


// check if all challenges in a tier are completed
tierCheck( tierID )
{
	challengeNames = getArrayKeys( level.challengeInfo );
	for ( index = 0; index < challengeNames.size; index++ )
	{
		challengeInfo = level.challengeInfo[challengeNames[index]];

		if ( challengeInfo["tier"] != tierID )
			continue;
			
		// multi level
		if ( challengeInfo["level"] > 1 )
			continue;
		
		// undefined means it's locked
		if ( !isDefined( self.challengeData[challengeNames[index]] ) )
			return false;
		
		// 255 means it's not completed
		if ( self.challengeData[challengeNames[index]] != 255 )
			return false;
	}

	return true;
}

challengeNotify( challengeName, challengeDesc )
{
	notifyData = spawnStruct();
	notifyData.titleText = &"MP_CHALLENGE_COMPLETED";
	notifyData.notifyText = challengeName;
	notifyData.notifyText2 = challengeDesc;
	notifyData.sound = "mp_challenge_complete";
	
	self maps\mp\gametypes\_hud_message::notifyMessage( notifyData );
}





// _RANK.GSC
/*
getRankInfoUnlockChallenge( rankId )
{
	return tableLookup( "mp/ranktable.csv", 0, rankId, 10 );
}

updateRank()
		// unlock challenge =====
		unlockedChallenge = self getRankInfoUnlockChallenge( rankId );
		if ( isDefined( unlockedChallenge ) && unlockedChallenge != "" )
			braxi\_missions::unlockChallenge( unlockedChallenge );
*/



