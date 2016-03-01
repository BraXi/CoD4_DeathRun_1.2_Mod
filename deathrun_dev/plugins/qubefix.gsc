/*

    Plugin:	 		Qube Fix
	Version:		1
	Requirement:	Easy fix no biggie
	Author:			Darmuh
	XFire:			irRoy8
	Homepage:		Raid-Gaming.net
	Date:			02.05.2013 & Updated 04.27.2014






*/
init( modversion )
{

  for(;;)
  {
     
	 level waittill( "round_ended" );
	 thread qube();
  
  }



}



qube()
{
	if( getDvar("mapname") == ("mp_deathrun_qube") || getDvar("mapname") == ("mp_dr_laboratory")  )
		{
			//setdvar("bunnyhoop", 0);
			iprintln( "^1>> ^3VIP ^7is a perk of ^2donating^7, go on the forums for more information." );
		}
	else
		{
			//setDvar("bunnyhoop", 1);
			setDvar("g_knockback",1000);
		}
}