/*
	I know that this script sux and is horribly shitty
	but i was in hurry so thats why its all big mess.
	Script written in 20 minutes, LOL.

	BraX.
	Xfire: maciusiak
*/

main()
{
	maps\mp\_load::main();

	game["allies"] = "marines";
	game["axis"] = "opfor";
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["allies_soldiertype"] = "desert";
	game["axis_soldiertype"] = "desert";

	level.trap1 = getEnt( "trap1", "targetname" );
	level.trap1_trig = getEnt( "t1", "targetname" );
	level.mover1 = getEnt( "mover1", "targetname" );
	level.pusher = getEnt( "pusher", "targetname" );
	level.pusher_trig = getEnt( "t2", "targetname" );
	level.c1 = getEnt( "cylinder1", "targetname" );
	level.c2 = getEnt( "cylinder2", "targetname" );
	level.c3 = getEnt( "cylinder3", "targetname" );
	level.c1_trig = getEnt( "t5", "targetname" );
	level.c2_trig = getEnt( "t6", "targetname" );
	level.c3_trig = getEnt( "t7", "targetname" );
	level.ft_trig = getEntArray( "t3", "targetname" )[0];
	level.ft1 = getEntArray( "fallTrap1", "targetname" );
	level.ft2 = getEntArray( "fallTrap2", "targetname" );
	level.pusher = getEnt( "pusher", "targetname" );
	level.pusher_trig = getEnt( "t2", "targetname" );
	level.pusher2 = getEnt( "mover2", "targetname" );
	level.pusher2_trig = getEnt( "t4", "targetname" );
	level.door = getEnt( "door", "targetname" );
	level.door_trig = getEnt( "openDoor", "targetname" );

	thread firstTrap();
	thread rotateCylinder1();
	thread rotateCylinder2();
	thread rotateCylinder3();
	thread goMover();
	thread goPusher();
	thread fallTrap();
	thread goSecondMover();
	thread openDoor();
}


openDoor()
{
	level.door_trig waittill( "trigger" );
	level.door_trig delete();
	brush = level.door;
	brush moveZ( 120, 7 );
}

goSecondMover()
{
	level.pusher2_trig waittill( "trigger" );
	level.pusher2_trig delete();
	brush = level.pusher2;

	startOrigin = brush.origin;
	moveOrigin = getEnt( brush.target, "targetname" ).origin;

	brush moveTo( moveOrigin, 1 );
	wait 6;
	brush moveTo( startOrigin, 1 );
}

fallTrap()
{
	level.ft_trig waittill( "trigger" );
	level.ft_trig  delete();
	
	level.ft1[randomInt(level.ft1.size)] notSolid();
	level.ft2[randomInt(level.ft2.size)] notSolid();
}

firstTrap()
{
	level.trap1_trig waittill( "trigger" );
	level.trap1_trig delete();
	brush = level.trap1;

	brush delete();
}

goPusher()
{
	level.pusher_trig waittill( "trigger" );
	level.pusher_trig delete();
	brush = level.pusher;

	startOrigin = brush.origin;
	moveOrigin = getEnt( brush.target, "targetname" ).origin;

	brush moveTo( moveOrigin, 1 );
	wait 3;
	brush moveTo( startOrigin, 1 );
}

goMover()
{
	brush = level.mover1;
	points = [];
	points[points.size] = getEnt( brush.target, "targetname" ).origin;
	points[points.size] = brush.origin;
	wait .05;
	while(1)
	{
		brush moveTo( points[0], 2 );
		wait 3;
		brush moveTo( points[1], 2 );
		wait 3;
	}
}

rotateCylinder1()
{
	level.c1_trig waittill( "trigger" );
	level.c1_trig delete();
	for( i = 0; i < 3; i++ )
	{
		level.c1 rotateYaw( 720, 3 );
		wait 3;
		level.c1 rotateYaw( -720, 3 );

	}
}
rotateCylinder2()
{
	level.c2_trig waittill( "trigger" );
	level.c2_trig delete();
	for( i = 0; i < 3; i++ )
	{
		level.c2 rotateYaw( 720, 3 );
		wait 3;
		level.c2 rotateYaw( -720, 3 );
	}
}

rotateCylinder3()
{
	level.c3_trig waittill( "trigger" );
	level.c3_trig delete();
	for( i = 0; i < 3; i++ )
	{
		level.c3 rotateYaw( 720, 3 );
		wait 3;
		level.c3 rotateYaw( -720, 3 );
	}
}