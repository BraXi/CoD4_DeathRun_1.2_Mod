main()
{
	maps\mp\_load::main();

	game["allies"] = "marines";
	game["axis"] = "opfor";
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["allies_soldiertype"] = "desert";
	game["axis_soldiertype"] = "desert";

	//Trap 1
	level.trap1_trig = getEnt( "t1", "targetname" );
	level.trap1 = getEnt("trap1", "targetname" );
	level.trap1_2 = getEnt("trap1_2", "targetname" );
	level.trap1_3 = getEnt("trap1_3", "targetname" );
	//Trap 2
	level.trap2_trig = getEnt( "t2", "targetname" );
	level.trap2 = getEnt("trap2", "targetname" );
	//Trap3

	level.trap3 = getEnt("trap3", "targetname" );
	level.trap3_trig = getEnt("t3", "targetname" );
	level.door = getEnt("end_door","targetname");
	level.doortrig = getEnt("end_door_trig","targetname");

	//Trap 4
	level.trap4 = getEnt("falle5","targetname");
	level.trap4_trig = getEnt("t4", "targetname" );

	//kill Trap
	level.trap5 = getEnt("kill_trig","targetname");
	level.trap5_2 = getEnt("kill_trig2","targetname");
	level.trap5_trig = getEnt("t5", "targetname" );

	//mover
	level.mover1 = getEnt( "mover1","targetname" );

	//Firebells
	level.trap1_druck = getEnt("d1","targetname");
	level.trap2_druck = getEnt("d2","targetname");
	level.trap3_druck = getEnt("d3","targetname");
	level.trap4_druck = getEnt("d4","targetname");
	level.trap5_druck = getEnt("d5","targetname");

	//Init
	thread trap1();
	thread mover();
	thread mover2();
	thread trap2();
	thread trap3();
	thread trap4();
	thread trap5();
	thread enddoor();
}
trap1()
{
level.trap1_trig waittill("trigger");
level.trap1_trig delete();
level.trap1_2 delete();
level.trap1_3 delete();
level.trap1 delete();
level.trap1_druck movez(-2,1);
}

mover()
{
	while(1)
	{
		level.mover1 movey(-472, 2);
		level.mover1 waittill ("movedone");
		wait 1;
		level.mover1 movey(472, 2);
		level.mover1 waittill ("movedone");
		wait 1;
	}
}

trap2()
{
	level.trap2_trig waittill("trigger");
	level.trap2_trig delete();
	level.trap2_druck movez(-2,1);
	level.trap2 movex(-150,1);
	wait 3;
	level.trap2 movex(150,1);
}
mover2()
{
	while(1)
	{
		level.trap3 movez(160,2);
		level.trap3 waittill ("movedone");
		wait 2;
		level.trap3 movez(-160,2);
		level.trap3 waittill ("movedone");
		wait 2;
	}
}
trap3()
{	
	level.trap3_trig waittill("trigger");
	level.trap3_trig delete();
	level.trap3_druck movez(-2,1);
	level.trap3 rotateyaw(1800,1);
	level.trap3 waittill("rotatedone");
	level.trap3 rotateyaw(1800,1);
	level.trap3 waittill("rotatedone");
	level.trap3 rotateyaw(1800,1);
	level.trap3 waittill("rotatedone");
	level.trap3 rotateyaw(1800,1);
}
trap4()
{
level.trap4_trig waittill("trigger");
level.trap4_trig delete();
level.trap4.origin = level.trap4.origin - (0,0,5000); //BraX
level.trap4 waittill("movedone");
wait 2;
level.trap4.origin = level.trap4.origin + (0,0,5000); //BraX
level.trap4_druck movez(-2,1);
}
trap5()
{
level.trap5_2 enablelinkto();
level.trap5_2 linkto(level.trap5);
level.trap5_trig waittill("trigger");
level.trap5_trig delete();
level.trap5 movex(-358,5);
level.trap5 waittill("movedone");
level.trap5_2 unLink(); //BraX
level.trap5_2 delete(); //BraX
level.trap5 movex(358,10);
level.trap5 waittill("movedone");
level.trap5_druck movez(-2,1);
}
enddoor()
{
	level.doortrig waittill("trigger");
	level.door movez (300,3);
	level.door waittill("movedone");
	iprintlnbold ("^2Door opened!"); //BraX
	level.door delete();
}