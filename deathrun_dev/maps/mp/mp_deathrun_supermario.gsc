/* Script map supermario beta by MR-X*/
main()
{
	//maps\mp\mp_deathrun_supermario_fx::main();
	maps\mp\_load::main();
	//maps\mp\_compass::setupMiniMap("compass_map_mp_deathrun_supermario");
	//setExpFog(500, 3500, .5, 0.5, 0.45, 0);
	ambientPlay("mario_ambient");
	//VisionSetNaked( "mp_deathrun_supermario" );
	
	game["allies"] = "sas";
	game["axis"] = "russian";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "woodland";
	game["axis_soldiertype"] = "woodland";

	setdvar( "r_specularcolorscale", "1" );

	setdvar("r_glowbloomintensity0",".1");
	setdvar("r_glowbloomintensity1",".1");
	setdvar("r_glowskybleedintensity0",".1");
	setdvar("compassmaxrange","1500");
	thread message1();
	thread trap1  ();
	thread trap2  ();
	thread trap3  ();
	thread plat   ();
	thread trap4  ();
	thread trap5  ();
	thread trap6  ();
	thread moving ();
	thread trap7  ();
	thread trap8  ();
	thread trap9  ();
	thread teleportertoflag ();
	thread lastmsg ();
	thread removalclips ();
}

// BraX
message1()
{
	wait 6;
	iprintln ("^3This map was created by ^2iNext'Mr-X");
	wait 1;
	iprintln ("^4Add me in Xfire ^1mousasalem");
	wait 1;
	iprintln ("^7This map is still in BETA version");
}
// <===

trap1 ()
	{
	trig_1 = getent ("trig1","targetname");
	brush_1 = getent ("brush_1","targetname");
	trig_1 waittill ("trigger");
	trig_1 delete ();
	while (1)
		{
		brush_1 rotatePitch (360 , 4 );
		wait 1 ;
		}
	}
	
trap2 ()
	{
	part1 = getentarray ("part_1" ,"targetname");
	part2 = getentarray ("part_2" ,"targetname");
	trig_2 = getent ("trig2" , "targetname");
	trig_2 waittill ("trigger" , player );
	trig_2 delete ();
	part1[randomInt(part1.size)] notsolid();
    part2[randomInt(part2.size)] notsolid();
	}
	
trap3 ()
	{
	trig_3 = getent ("trig3","targetname");
	brush_3 = getent ("brush_3","targetname");
	killa = getent ("kill","targetname");
	//brush = getent (brush_3.target, "targetname");
	
	trig_3 waittill ("trigger");
	trig_3 delete ();
	
	//oldorigin = brush_3.origin ;
	
	killa enablelinkto ();
	killa linkto (brush_3);
	
	brush_3 rotateroll(180,1);
	wait 4 ;
	brush_3 rotateroll (-180, 1 );
	wait 4 ; 
	}
plat ()
	{
	platform = getent ("platform","targetname");
	mov = getent (platform.target , "targetname");
	
	oldorigin = platform.origin ;
	
	while (1)
		{
		platform moveto (mov.origin , 2 );
		wait 2.5 ;
		platform moveto (oldorigin , 2 );
		wait 2.5 ; 
		}
		
	}
	
trap4 ()
	{
	trig_4 = getent ("trig4","targetname");
	spikes = getent ("spikes","targetname");
	kill1 = getent ("kill1","targetname");
	
	trig_4 waittill ("trigger",player);
	trig_4 delete ();
	
	kill1 enablelinkto();
	kill1 linkto (spikes);
	spikes movez (24 , 0.1);
	wait 2;
	
	spikes movez (-24 , 0.5 );
	wait 2 ;
	
	}
	
trap5 ()
	{
	trig_5 = getent ("trig5","targetname");
	brush_5 = getent ("brushro","targetname");
	
	trig_5 waittill ("trigger",player);
	trig_5 delete ();
	
	while (1)
		{
		brush_5 rotateyaw (360 , 4);
		wait 1 ;
		}
		
	}

trap6 ()
	{
	half_1 = getentarray ("half_1" ,"targetname");
	half_2 = getentarray ("half_2" ,"targetname");
	trig_6 = getent ("trig6" , "targetname");
	trig_6 waittill ("trigger" , player );
	trig_6 delete ();
	half_1[randomInt(half_1.size)] delete();
    half_2[randomInt(half_2.size)] delete();
	}
	
moving ()
	{
	br1 = getent ("br1","targetname");
	br2 = getent ("br2","targetname");
	b3 = getent (br1.target,"targetname");
	b4 = getent (br2.target,"targetname");
	
	oldorigin1 = br1.origin;
	oldorigin2 = br2.origin;
	
	while (1)
		{
		br1 moveto(b3.origin , 1.5);
		br2 moveto (b4.origin , 1.5);
		wait 1.51;
		br1 moveto(oldorigin1 , 1.5);
		br2 moveto (oldorigin2 , 1.5);
		wait 1.51;
		}
	}

// BraX
trap7()
{
	hid = getent ( "hid", "targetname" );
	hid hide ();
	
	sh = getent( "sh", "targetname" );
	teleporter = getent( "teleporter", "targetname" );
	fill = getent( "fill", "targetname" );
	trig_7 = getent( "trig7", "targetname" );
	
	trig_7 waittill( "trigger", player );
	trig_7 delete();
	
	wait 0.1;
	hid show();
	sh hide();
	
	time = 10;
	for( i = 0; i < time*5; i++ )
	{
		players = getEntArray( "player", "classname" );	
		for( j = 0; j < players.size; j++ )
		{
			if( players[j].sessionstate == "playing" && players[j] isTouching ( teleporter ) )
			{
				players[j] setOrigin( fill.origin );
			}
		}
		wait 0.2;
	}

	hid hide();
	sh show();
	teleporter delete();
}
// <===	
	
trap8 ()
	{
	trig_8 = getent ("trig8","targetname");
	brush_8 = getent ("fall1","targetname");
	killer = getent ("killer","targetname");
	trag = getent (brush_8.target , "targetname");
	
	trig_8 waittill ("trigger");
	trig_8 delete ();
	
	oldorigin = brush_8.origin ;
	killer enablelinkto ();
	killer linkto (brush_8);
	
	brush_8 moveto (trag.origin , 0.01 );
	wait 4 ;
	brush_8 delete ();
	killer delete ();
	
	}
	
trap9 ()
	{
	trig_9 = getent ("trig9","targetname");
	brush_9 = getent ("fall2","targetname");
	killer1 = getent ("killer1","targetname");
	trag1 = getent (brush_9.target , "targetname");
	
	trig_9 waittill ("trigger");
	trig_9 delete ();
	
	oldorigin = brush_9.origin ;
	killer1 enablelinkto ();
	killer1 linkto (brush_9);
	
	brush_9 moveto (trag1.origin , 0.01 );
	wait 4 ;
	brush_9 delete ();
	killer1 delete ();
	}

teleportertoflag ()
	{
	 seta = getent ("seta","targetname");
	 sets = getent (seta.target,"targetname");
	 
	 while (1)
		{
		seta waittill ("trigger",Mrx); // ;D
		Mrx setorigin (sets.origin , 0.5);
		wait 0.5 ;
		}
	}
	
lastmsg ()
	{
	ms = getent ("ms","targetname");
	ms waittill ("trigger",player );
	ms delete ();

	
	iprintlnbold ("Gratz" + "." + "^2"+ player.name + "^7."+ "finished SuperMario map at 1st place");
	wait 1 ;
	}
	
removalclips () 
	{
	flas = getent ("flas","targetname");
	fla = getent (flas.target,"targetname");
	oldorigin = flas.origin;
	ma = fla.origin;
	
	clips = getent ("remove","targetname");
	trigdown = getent ("down","targetname");
	
	trigdown waittill ("trigger",player);
	trigdown delete ();
	
	player PlaySound ("endofgame");
	flas moveto (ma , 1.5);
	wait 1 ;
	
	clips delete ();
	}