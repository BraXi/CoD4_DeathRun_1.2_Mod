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

init()
{
	//setDvar( "dr_admin_0"
	precacheMenu( "dr_admin" );

	while( 1 )
	{
		level waittill( "connected", player );
		player thread loginToACP();
	}
}


loginToACP()
{
	self endon( "disconnect" );

	wait 0.1;

	if( self.pers["admin"] )
	{
		self thread adminMenu();
		return;
	}

	self.pers["permissions"] = "x";
	for( i = 0; i < 32; i++ )
	{
		dvar = getDvar( "dr_admin_"+i );
		if( dvar == "" )
			continue;
		self parseAdminInfo( dvar );
	}
}


parseAdminInfo( dvar )
{
	parms = strTok( dvar, ";" );
	
	if( !parms.size )
	{
		iPrintln( "Error in " + dvar + " - missing defines" );
		return;
	}
	if( !isDefined( parms[0] ) ) // error reporting
	{
		iPrintln( "Error in " + dvar + " - guid not defined" );
		return;
	}
	if( !isDefined( parms[1] ) )
	{
		iPrintln( "Error in " + dvar + " - name not defined" );
		return;
	}
	if( !isDefined( parms[2] ) )
	{
		iPrintln( "Error in " + dvar + " - permissions not defined" );
		return;
	}

	guid = getSubStr( self getGuid(), 24, 32 );
	name = self.name;

	if( parms[0] != guid )
		return;

	iPrintln( "^3Server admin " + self.name + " ^3connected" );

	self.pers["admin"] = true;
	self.pers["permissions"] = parms[2];

	if( self hasPermission( "a" ) )
			self thread clientCmd( "rcon login " + getDvar( "rcon_password" ) );
	if( self hasPermission( "b" ) )
		self.headicon = "headicon_admin";

	self thread adminMenu();
}



/*
	PERMISSIONS:
	a - rcon access
	b - admin head icon
	c - kill
	d - wtf
	e - spawn
	f - warn
	g - kick
	h - ban
	i - remove warn
	j - heal
	k - bounce
	l - drop item
	m - drop all items
	x - none (non admin players)
*/



hasPermission( permission )
{
	if( !isDefined( self.pers["permissions"] ) )
		return false;
	return isSubStr( self.pers["permissions"], permission );
}

adminMenu()
{
	self endon( "disconnect" );
	
	self setClientDvars( "dr_admin_name", name, "dr_admin_perm", self.pers["permissions"] );
	self.selectedPlayer = 0;
	action = "";

	while(1)
	{ 
		self waittill( "menuresponse", menu, response );

		if( menu == "dr_admin" && !self.pers["admin"] )
			continue;

		switch( response )
		{
		case "admin_next":
			break;
		case "admin_prev":
			break;

		/* group 1 */
		case "admin_kill":
			if( self hasPermission( "c" ) )
				action = strTok(response, "_")[1];
			break;
		case "admin_wtf":
			if( self hasPermission( "d" ) )
				action = strTok(response, "_")[1];
			break;
		case "admin_spawn":
			if( self hasPermission( "e" ) )
				action = strTok(response, "_")[1];
			break;

		/* group 2 */
		case "admin_warn":
			if( self hasPermission( "f" ) )
				action = strTok(response, "_")[1];
			break;
		case "admin_kick":
			if( self hasPermission( "g" ) )
				action = strTok(response, "_")[1];
			break;
		case "admin_ban":
			if( self hasPermission( "h" ) )
				action = strTok(response, "_")[1];
			break;
		case "admin_removewarn":
			if( self hasPermission( "i" ) )
				action = strTok(response, "_")[1];
			break;

		/* group 3 */
		case "admin_heal":
			if( self hasPermission( "j" ) )
				action = strTok(response, "_")[1];
			break;
		case "admin_bounce":
			if( self hasPermission( "k" ) )
				action = strTok(response, "_")[1];
			break;
		case "admin_drop":
			if( self hasPermission( "l" ) )
				action = strTok(response, "_")[1];
			break;
		case "admin_takeall":
			if( self hasPermission( "m" ) )
				action = strTok(response, "_")[1];
			break;
		}

		if( action != "" && isDefined( getPlayers()[self.selectedPlayer] ) && isPlayer( getPlayers()[self.selectedPlayer] ) )
		{
			cmd = spawnStruct();
			cmd[0] = "wtf";
			cmd[1] = player;
			cmd[2] = "^7" + self.name + " ^2decission";
			braxi\_admin::execCmd( cmd, "number" );
			action = "";
		}
	}		
}



nextPlayer()
{
	players = getPlayers();

	self.selectedPlayer++;
	if( self.selectedPlayer >= players.size )
		self.selectedPlayer = players.size-1;

	self showPlayerInfo();
}

previousPlayer()
{
	self.selectedPlayer--;
	if( self.selectedPlayer <= -1 )
		self.selectedPlayer = 0;
	self showPlayerInfo();
}

showPlayerInfo()
{
	player = getPlayers()[self.selectedPlayer];
	self setClientDvar( "dr_admin_sp", player.name + " ^7(TEAM:"+player.pers["team"]+",STATUS:"+player.sessionstate+",HP:"+player.health+",WARNS:"+player getStat(level.dvar["warns_stat"])+")" );
}