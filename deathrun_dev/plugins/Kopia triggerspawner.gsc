//
// Plugin name: Trigger Spawner
// Author: BraXi
// Version: 1.0
// Website: www.braxi.cba.pl
// Description: Displays welcome message for newly connected player
//
// This plugin was designed for Death Run, after some tweaks it may also work with 
// other mods, but please give credits to me if you find this useful in your mod.
//

init( modVersion )
{
	thread playerSpawned();
}

playerSpawned()
{
	while( 1 )
	{
		level waittill( "player_spawn", player );
	
		player iprintln( "do the job, low" );
		player thread doTheJob();
	}
}


doTheJob()
{
	self.health = 999999999;

	self.devHuds = [];

	self.devHuds[0] = braxi\_mod::addTextHud( self, 10, 120, 1, "left", "middle", 1.9 ); // selected trigger
	self.devHuds[1] = braxi\_mod::addTextHud( self, 10, 135, 1, "left", "middle", 1.9 ); // width
	self.devHuds[2] = braxi\_mod::addTextHud( self, 10, 150, 1, "left", "middle", 1.9 ); // height
	self.devHuds[3] = braxi\_mod::addTextHud( self, 10, 165, 1, "left", "middle", 1.9 ); // origin
	self.devHuds[4] = braxi\_mod::addTextHud( self, 320, 20, 1, "center", "top", 1.4 );	// usage

	for( i = 0; i < self.devHuds.size; i++ )
	{
		self.devHuds[i].horzAlign = "fullscreen";
		self.devHuds[i].vertAlign = "fullscreen";
	}

	self.devHuds[0] setText( "Trigger not selected" );
	self.devHuds[4] setText( "MELEE - spawn trig, USE - +5width, FRAG - +5 height, MELEE+ADS - solid? ATTACK - save" );
	
	//========================================================

	self.selectedTrigger = undefined;

	while( 1 )
	{
		wait 0.5;

		if( isDefined( self.selectedTrigger ) && self playerAds() && self meleeButtonPressed() )
		{
			if( self.selectedTrigger.solid )
				self.selectedTrigger.solid = 0;
			else
				self.selectedTrigger.solid = 1;

			iprintln( "Solid = " + self.selectedTrigger.solid );
			continue;
		}

		if( self meleeButtonPressed() )
		{
			self.selectedTrigger = self placeTrigger( self.origin, 10, 10 );
		}

		if( isDefined( self.selectedTrigger ) )
		{
			if( self useButtonPressed() )
			{
				width = self.selectedTrigger.width+5;
				height = self.selectedTrigger.height;
				origin = self.selectedTrigger.origin;
				self.selectedTrigger delete();
				self.selectedTrigger = self placeTrigger( origin, width, height );
			}


			if( self fragButtonPressed() )
			{
				width = self.selectedTrigger.width;
				height = self.selectedTrigger.height+5;
				origin = self.selectedTrigger.origin;
				self.selectedTrigger delete();
				self.selectedTrigger = self placeTrigger( origin, width, height );
			}

			if( self attackButtonPressed() )
			{
				logPrint( "SCRIPT_GEN: trigger = spawn( \"trigger_radius\", "+ self.selectedTrigger.origin + ", 0, " + self.selectedTrigger.width + ", " + self.selectedTrigger.height + " );\n" );
			}

			self.devHuds[0] setText( "Selected: " + self.selectedTrigger getEntityNumber() );
			self.devHuds[1] setText( "Width: " + self.selectedTrigger.width );
			self.devHuds[2] setText( "Height: " + self.selectedTrigger.height );
			self.devHuds[3] setText( "Origin: " + self.selectedTrigger.origin );
		}
	}
}

placeTrigger( origin, width, height )
{
	ent = spawn( "trigger_radius", origin, 0, width, height );
	ent.width = width;
	ent.height = height;
	ent.solid = 0;

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





drawTrigger2()
{
	num = self getEntityNumber();
	while( isDefined( self ) )
	{
		/#
		print3d( self.origin, "Trig ("+num+")", (1.0, 0.8, 0.5), 1, 0.4 );
		print3d( self.origin+(0,0,20), "Width: "+self.width, (0, 0.5, 0), 1, 0.2 );
		print3d( self.origin+(0,0,10), "Height: "+self.height, (0, 0.5, 0), 1, 0.2 );

		center = self.origin;
		forward = anglestoforward( self.angles );
		right = anglestoright( self.angles );

		forward = maps\mp\_utility::vector_scale( forward, self.width );
		right = maps\mp\_utility::vector_scale( right, self.width );

		a = center + forward - right;
		b = center + forward + right;
		c = center - forward + right;
		d = center - forward - right;

		line( a, b, (0.9, 0.7, 0.6), false );
		line( b, c, (0.9, 0.7, 0.6), false );
		line( c, d, (0.9, 0.7, 0.6), false );
		line( d, a, (0.9, 0.7, 0.6), false );

		line( a, a + (0, 0, self.height), (0.9, 0.7, 0.6), false );
		line( b, b + (0, 0, self.height), (0.9, 0.7, 0.6), false );
		line( c, c + (0, 0, self.height), (0.9, 0.7, 0.6), false );
		line( d, d + (0, 0, self.height), (0.9, 0.7, 0.6), false );

		a = a + (0, 0, self.height);
		b = b + (0, 0, self.height);
		c = c + (0, 0, self.height);
		d = d + (0, 0, self.height);

		line( a, b, (0.9, 0.7, 0.6), false );
		line( b, c, (0.9, 0.7, 0.6), false );
		line( c, d, (0.9, 0.7, 0.6), false );
		line( d, a, (0.9, 0.7, 0.6), false );

		/*thread lineUntilNotified(a, b, color, 0);
		thread lineUntilNotified(b, c, color, 0);
		thread lineUntilNotified(c, d, color, 0);
		thread lineUntilNotified(d, a, color, 0);*/
		/*x01 = self.origin - (self.width,0,0);
		x02 = self.origin + (self.width,0,0);
		y01 = self.origin - (0,self.width,0);
		y02 = self.origin + (0,self.width,0);
		x11 = self.origin - (self.width,0,0) + (0,0,self.height);
		x12 = self.origin + (self.width,0,0) + (0,0,self.height);
		y11 = self.origin - (0,self.width,0) + (0,0,self.height);
		y12 = self.origin + (0,self.width,0) + (0,0,self.height);

		// dol-gora
		line( x01, x11, (0.9, 0.7, 0.6), false );
		line( x02, x12, (0.9, 0.7, 0.6), false );
		line( y01, y11, (0.9, 0.7, 0.6), false );
		line( y02, y12, (0.9, 0.7, 0.6), false );

		line( self.origin, self.origin - (self.width,0,0), (0.9, 0.7, 0.6), false );
		line( self.origin, self.origin + (self.width,0,0), (0.9, 0.7, 0.6), false );
		line( self.origin, self.origin - (0,self.width,0), (0.9, 0.7, 0.6), false );
		line( self.origin, self.origin + (0,self.width,0), (0.9, 0.7, 0.6), false );

		line( self.origin - (self.width,0,0), self.origin - (self.width,0,0)+(0,0,self.height), (0.9, 0.7, 0.6), false );
		line( self.origin - (0,self.width,0), self.origin - (0,self.width,0)+(0,0,self.height), (0.9, 0.7, 0.6), false );
		line( self.origin + (self.width,0,0), self.origin + (self.width,0,self.height), (0.9, 0.7, 0.6), false );
		line( self.origin + (0,self.width,0), self.origin + (0,self.width,self.height), (0.9, 0.7, 0.6), false );

		line( self.origin+(0,0,self.height), self.origin - (self.width,0,0)+(0,0,self.height), (0.9, 0.7, 0.6), false );
		line( self.origin+(0,0,self.height), self.origin + (self.width,0,0)+(0,0,self.height), (0.9, 0.7, 0.6), false );
		line( self.origin+(0,0,self.height), self.origin - (0,self.width,0)+(0,0,self.height), (0.9, 0.7, 0.6), false );
		line( self.origin+(0,0,self.height), self.origin + (0,self.width,0)+(0,0,self.height), (0.9, 0.7, 0.6), false );

		line( self.origin, self.origin + (0,0,self.height), (0.2, 0.7, 0.6), false );
		*/
		#/
		wait 0.05;
	}
}


