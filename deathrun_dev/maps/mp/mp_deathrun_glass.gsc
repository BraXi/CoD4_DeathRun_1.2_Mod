main()
{;
	maps\mp\_load::main();
	
	//maps\mp\_compass::setupMiniMap("compass_map_mp_dusk");
	
	setExpFog(300, 3500, .5, 0.5, 0.45, 0);
	ambientPlay("ambient_dusk");
	VisionSetNaked( "armada_ground" );

	game["allies"] = "marines";
	game["axis"] = "opfor";
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["allies_soldiertype"] = "desert";
	game["axis_soldiertype"] = "desert";

	setdvar( "r_specularcolorscale", "1" );
	thread door1 ();
	thread trap1 ();
	thread trap2 ();
	thread trap3 ();
    thread trap4 ();
	thread trap5 ();
	thread trap6 ();
	thread pushers ();
	thread trap7 ();
	thread trap8 ();
	thread trap9 ();
	thread movingbrushs ();
	thread lastdoor1 ();
}

door1()
{
	door_1 = getEnt ("firstdoor","targetname");
	trigg = getEnt ("triga","targetname");
	trigg waittill ("trigger");
	trigg delete ();
	door_1 movez (160 , 2);
}

trap1() 
{
	trig_1 = getent ("trig_1","targetname");
	brush1a = getent ("brush1a","targetname");
	brush1 = getent ("brush1","targetname");
	killtrig = getent ("killtrig","targetname");

	trig_1 waittill ("trigger");
	trig_1 delete ();
	killtrig enablelinkto();
	killtrig linkto (brush1a);
	brush1a linkto (brush1);
	brush1 rotateroll (-90 , 0.5);
	wait 0.6 ; 
	while (1)
	{
		brush1 rotateroll (180 , 1);
		wait 1.1;
		brush1 rotateroll (-180 , 1);
		wait 1.1;
	}
}

trap2()
{
	brush2 = getent ("brush2","targetname");
	brush2a = getent ("brush2a","targetname");
	trig_2 = getent ("trig_2","targetname");
	
	trig_2 waittill ("trigger");
	trig_2 delete ();
	while (1)
	{
		brush2 rotateyaw (1080 , Randomfloat( 3 )+1 );
		brush2a rotateyaw (-720 , Randomfloat( 4 )+1);
		wait 4.1;
		brush2 rotateyaw (-360 , Randomfloat( 1.5 )+1 );
		brush2a rotateyaw (360 , Randomfloat( 2 )+1);
		wait 2;
		brush2a rotateyaw (-720 , Randomfloat( 2 )+1);
		brush2 rotateyaw (1080 , Randomfloat( 4 )+1 );
		wait 2;
	}
}

trap3()
{
	rock = getent ("rock","targetname");
	trig_3 = getent ("trig_3","targetname");
	
	trig_3 waittill ("trigger");
	trig_3 delete();
	rock movey (250, 0.5 );
	wait 4;
	rock movey (-250, 0.5 );
}

trap4()
{
	killer = getent("killer","targetname");
	brush4 = getent("brush4","targetname");
	trig_4 = getent ("trig_4","targetname");
	
	trig_4 waittill ("trigger");
	trig_4 delete();
	
	killer enablelinkto();
	killer linkto (brush4);
	brush4 movez (24 , 0.5);
	wait 4; 
	brush4 movez(-24,4);
	wait 5;
}

trap5()
{
	trig_5 = getent ("trig_5" , "targetname");
	brush5 = getent ("brush5","targetname");
	
	trig_5 waittill ("trigger");
	trig_5 delete ();
	
	while (1)
	{
		brush5 rotateroll(-360 , 2.5);
		wait 1;
	}
}


trap6() 
{
	trig6 = getent ( "trig_6" , "targetname" ) ;
	half_1= getentarray ( "half_1","targetname" ) ;
	half_2 = getentarray ( "half_2" , "targetname");
	
	trig6 waittill ("trigger", player );
	trig6 delete ();
	
	half_1[randomInt(half_1.size)] delete();
	half_2[randomInt(half_2.size)] delete();

}

pushers()
{
	push1 = getent ("pusher1","targetname" );
	push2 = getent ("pusher2","targetname" );
	push3 = getent ("pusher3","targetname" );
	push4 = getent ("pusher4","targetname" );
	
	push1 rotateroll (30 ,0.4);
	push2 rotateroll (-30 ,0.4);
	push3 rotateroll (30 ,0.4);
	push4 rotateroll (-30 ,0.4);

	wait 0.4;
	while (1) 
	{
			
		push1 rotateroll (-60 ,0.8);
		push2 rotateroll (60 ,0.8);
		push3 rotateroll (-60 ,0.8);
		push4 rotateroll (60 ,0.8);
		wait 0.8;
		push1 rotateroll (60 ,0.8);
		push2 rotateroll (-60 ,0.8);
		push3 rotateroll (60 ,0.8);
		push4 rotateroll (-60 ,0.8);
		wait 0.8;
	}
}

trap7 ()
{
	m1= getentarray ("m1","targetname");
	trig_7 = getent ("trig_7","targetname");

	trig_7 waittill ("trigger");
	trig_7 delete ();

	for (i=0;i<m1.size;i++)
	{
		m1[i] movey (-170 , randomfloat (1)+0.5);
		wait 2 ; 
		m1[i] movey (170 , randomfloat (1)+0.5);
		wait 2 ;
	}
}

// >===== BraX ======<
trap8()
{
	level endon( "trap8 goes away" );
	trig_8 = getent ("trig_8","targetname");
	brush8 = getent ("brush8","targetname");
	fly = getent ("fly","targetname");
	n1 = getent ("n1","targetname");
	n2 = getent ("n2","targetname");
	n3 = getent ("n3","targetname");
	n4 = getent ("n4","targetname");			
	liko = getent ("liko","targetname");

	trig_8 waittill ("trigger");
	trig_8 delete ();

	level thread trap8_secondThread( brush8 );
	wait 0.1;

	while ( 1 )
	{
		liko waittill ( "trigger", player );
		if ( player istouching ( liko ) )
		{
			player.health = ( player.health + 70 );
			player finishPlayerDamage( player, player, 70, 0, "MOD_PROJECTILE", "rpg_mp", player.origin, vectornormalize(player.origin - brush8.origin), "none", 0 );
			player stopRumble();
		}
	}
}

trap8_secondThread( brush8 )
{
	for( i = 0; i < 20; i++ )
	{
		brush8 rotatePitch( 360, 1 );
		wait 1;
	}
	level notify( "trap8 goes away" );
}
// >===== END OF BRAX ======<

trap9 ()
{
	part1 = getentarray ("part_1" ,"targetname");
	part2 = getentarray ("part_2" ,"targetname");
	trig9 = getent ("trig_9" , "targetname");

	trig9 waittill ("trigger" , player );
	trig9 delete ();

	part1[randomInt(part1.size)] notsolid();
	part2[randomInt(part2.size)] notsolid();
			
}
			
movingbrushs ()
{
	brusha = getent ("brusha","targetname");
	brushb = getent ("brushb","targetname");
	brushc = getent ("brushc","targetname");
			
	brusha movex (-32 , 0.5);
	brushb movex (32 , 0.5);
			
	wait 0.5;
			
	while (1)
	{
		brushc rotatepitch (360 , 1.5 ); 
		brusha movex (64 , 0.7);
		brushb movex (-64 , 0.7);
		wait 0.7 ; 
		brusha movex (-64 , 0.7);
		brushb movex (64 , 0.7);
		wait 0.7 ; 
	}
}

lastdoor1 ()
{
	lastdoor = getent ("lastdoor","targetname");
	trigdoor= getent ("trigdoor","targetname");
	trigdoor waittill ("trigger");
	trigdoor delete ();
	lastdoor rotateyaw (90 , 1.5);
	wait 1;
}
			