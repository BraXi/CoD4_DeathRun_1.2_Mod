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
	thread playerSpawned();
}

playerSpawned()
{
	while( 1 )
	{
		level waittill( "player_spawn", player );
	
		player notify( "end this shit job" );
		player thread doTheJob();
		player thread commands();
	}
}

commands()
{
	self endon( "disconnect" );
	self endon( "death" );
	while( 1 )
	{
		self waittill( "menuresponse", menu, cmd );

		if( cmd == "save" && isDefined( self.selectedTrigger ) )
		{
			logPrint( "SCRIPT_GEN:\ntrigger = spawn( \"trigger_radius\", "+ self.selectedTrigger.origin + ", 0, " + self.selectedTrigger.width + ", " + self.selectedTrigger.height + " );\n" );
			if( self.selectedTrigger.solid )
				logPrint( "trigger setContents( 1 ); //solid\n" );

			iPrintlnBold( "saved trigger " + self.selectedTrigger getEntityNumber() );
		}

	}

}

doTheJob()
{
	self endon( "disconnect" );
	self endon( "death" );
	self endon( "end this shit job" );

	self.health = 999999999;


	if( !isDefined( self.devHuds ) )
	{
		self.devHuds = [];

		self.devHuds[0] = braxi\_mod::addTextHud( self, 10, 120+50, 1, "left", "middle", 1.4 ); // selected trigger
		self.devHuds[1] = braxi\_mod::addTextHud( self, 10, 135+50, 1, "left", "middle", 1.4 ); // width
		self.devHuds[2] = braxi\_mod::addTextHud( self, 10, 150+50, 1, "left", "middle", 1.4 ); // height
		self.devHuds[3] = braxi\_mod::addTextHud( self, 10, 165+50, 1, "left", "middle", 1.4 ); // origin
		self.devHuds[4] = braxi\_mod::addTextHud( self, 7, 5, 1, "left", "top", 1.4 );	// usage

		for( i = 0; i < self.devHuds.size; i++ )
		{
			self.devHuds[i].horzAlign = "fullscreen";
			self.devHuds[i].vertAlign = "fullscreen";
		}
		self.devHuds[4] setText( "^3melee^7 - spawn trig,\n^3attack^7 - select trigger \n^3use^7 - +5width\n^3frag^7 - +5 height\n^3offhand^7 - toggle solid\n^3\\openscriptmenu -1 save ^7- save selected trigger" );
	}
	//========================================================

	self.selectedTrigger = undefined;

	while( self.sessionstate == "playing" )
	{
		wait 0.5;


		if( self meleeButtonPressed() )
		{
			self.selectedTrigger = self placeTrigger( self.origin, 10, 10, 0 );
		}

		if( self attackButtonPressed() )
		{
			ents = getEntArray( "trigger_radius", "classname" );
			for( i = 0; i < ents.size; i++ )
			{
				if( distance( ents[i].origin, self.origin ) < 32 )
				{
					self.selectedTrigger = ents[i];
					iPrintlnBold( "selected trigger " + self.selectedTrigger getEntityNumber() );
					break;
				}
			}
		}

		if( !isDefined( self.selectedTrigger ) )
		{
			self.devHuds[0] setText( "Trigger not selected" );
			for( i = 1; i < self.devHuds.size-1; i++ )
				self.devHuds[i] setText( " " );
			continue;
		}

		//========================================================

		if( self secondaryOffhandButtonPressed() )
		{
			if( self.selectedTrigger.solid )
				self.selectedTrigger.solid = 0;
			else
				self.selectedTrigger.solid = 1;

			iprintln( "Solid = " + self.selectedTrigger.solid );
			continue;
		}

		if( self useButtonPressed() ) //width
		{
			width = self.selectedTrigger.width+5;
			height = self.selectedTrigger.height;
			origin = self.selectedTrigger.origin;
			solid = self.selectedTrigger.solid;
			self.selectedTrigger delete();
			self.selectedTrigger = self placeTrigger( origin, width, height, solid );
		}


		if( self fragButtonPressed() ) // height
		{
			width = self.selectedTrigger.width;
			height = self.selectedTrigger.height+5;
			origin = self.selectedTrigger.origin;
			solid = self.selectedTrigger.solid;
			self.selectedTrigger delete();
			self.selectedTrigger = self placeTrigger( origin, width, height, solid );
		}

		self.devHuds[0] setText( "Selected: " + self.selectedTrigger getEntityNumber() );
		self.devHuds[1] setText( "Width: " + self.selectedTrigger.width );
		self.devHuds[2] setText( "Height: " + self.selectedTrigger.height );
		self.devHuds[3] setText( "Origin: " + self.selectedTrigger.origin );
	}
}

placeTrigger( origin, width, height, solid )
{
	ent = spawn( "trigger_radius", origin, 0, width, height );
	ent.width = width;
	ent.height = height;
	ent.solid = solid;

	ent thread triggerThink();

	return ent;
}

triggerThink()
{
	num = self getEntityNumber();
	while( isDefined( self ) )
	{
		/#
		print3d( self.origin, "Trig ("+num+")", (1.0, 0.8, 0.5), 1, 0.4 );
		print3d( self.origin+(0,0,15), "Width: "+self.width, (0, 0.5, 0), 1, 0.2 );
		print3d( self.origin+(0,0,10), "Height: "+self.height, (0, 0.5, 0), 1, 0.2 );

		self setContents( self.solid );
		if( self.solid )
			print3d( self.origin+(0,0,20), "SOLID", (0.6, 0, 0), 1, 0.2 );
		else
			print3d( self.origin+(0,0,20), "NOT SOLID", (0.6, 0, 0), 1, 0.2 );

		center = self.origin;
		forward = anglestoforward( self.angles );
		right = anglestoright( self.angles );

		forward = maps\mp\_utility::vector_scale( forward, self.width );
		right = maps\mp\_utility::vector_scale( right, self.width );


		a = center + forward - right;
		b = center + forward + right;
		c = center - forward + right;
		d = center - forward - right;
		////////
		/*a = center + forward*0.7 - right; //lewa
		b = center + forward;

		c = center + forward*0.7 + right; // prawa
		d = center + right;

		e = center - forward + right;
		f = center - forward;

		g = center - forward - right;
		h = center - right;*/


		//   _
		//  / \
		//  \_/
		//
		//
		//

		line( a, b, (0.9, 0.7, 0.6), false );
		line( b, c, (0.9, 0.7, 0.6), false );
		line( c, d, (0.9, 0.7, 0.6), false );
		line( d, a, (0.9, 0.7, 0.6), false );
		/*line( e, f, (0.9, 0.7, 0.6), false );
		line( f, g, (0.9, 0.7, 0.6), false );
		line( g, h, (0.9, 0.7, 0.6), false );
		line( h, a, (0.9, 0.7, 0.6), false );*/

		line( a, a + (0, 0, self.height), (0.9, 0.7, 0.6), false );
		line( b, b + (0, 0, self.height), (0.9, 0.7, 0.6), false );
		line( c, c + (0, 0, self.height), (0.9, 0.7, 0.6), false );
		line( d, d + (0, 0, self.height), (0.9, 0.7, 0.6), false );
		/*line( e, e + (0, 0, self.height), (0.9, 0.7, 0.6), false );
		line( f, f + (0, 0, self.height), (0.9, 0.7, 0.6), false );
		line( g, g + (0, 0, self.height), (0.9, 0.7, 0.6), false );
		line( h, h + (0, 0, self.height), (0.9, 0.7, 0.6), false );*/

		a = a + (0, 0, self.height);
		b = b + (0, 0, self.height);
		c = c + (0, 0, self.height);
		d = d + (0, 0, self.height);

		line( a, b, (0.9, 0.7, 0.6), false );
		line( b, c, (0.9, 0.7, 0.6), false );
		line( c, d, (0.9, 0.7, 0.6), false );
		line( d, a, (0.9, 0.7, 0.6), false );

		#/
		wait 0.05;
	}
}

/*
trigger = spawn( "trigger_radius", (9329.7, 380.853, 128.125), 0, 255, 140 ); //ruin2

trigger = spawn( "trigger_radius", (334.089, -1482.11, 8.125), 0, 175, 85 ); // mario

*/