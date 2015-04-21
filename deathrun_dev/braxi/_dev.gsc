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
	if(getdvar("scr_showspawns") == "")
		setdvar("scr_showspawns", "0");

	precacheItem("defaultweapon_mp");

	thread addTestClients();
		
	for(;;)
	{
		updateDevSettings();
		wait .05;
	}
	
}

showSpawnpoints()
{
	if(!isdefined(level.spawnpoints))
		return;
	
	for(i = 0; i < level.spawnpoints.size; i++)
	{
		spawnpoint = level.spawnpoints[i];
		
		//color = spawnpoint._color;
		//if(!isdefined(color))
			color = (1, 1, 1);

		center = spawnpoint.origin;
		forward = anglestoforward(spawnpoint.angles);
		right = anglestoright(spawnpoint.angles);

		forward = maps\mp\_utility::vector_scale(forward, 16);
		right = maps\mp\_utility::vector_scale(right, 16);

		a = center + forward - right;
		b = center + forward + right;
		c = center - forward + right;
		d = center - forward - right;
		
		thread lineUntilNotified(a, b, color, 0);
		thread lineUntilNotified(b, c, color, 0);
		thread lineUntilNotified(c, d, color, 0);
		thread lineUntilNotified(d, a, color, 0);

		thread lineUntilNotified(a, a + (0, 0, 72), color, 0);
		thread lineUntilNotified(b, b + (0, 0, 72), color, 0);
		thread lineUntilNotified(c, c + (0, 0, 72), color, 0);
		thread lineUntilNotified(d, d + (0, 0, 72), color, 0);

		a = a + (0, 0, 72);
		b = b + (0, 0, 72);
		c = c + (0, 0, 72);
		d = d + (0, 0, 72);
		
		thread lineUntilNotified(a, b, color, 0);
		thread lineUntilNotified(b, c, color, 0);
		thread lineUntilNotified(c, d, color, 0);
		thread lineUntilNotified(d, a, color, 0);

		center = center + (0, 0, 36);
		arrow_forward = anglestoforward(spawnpoint.angles);
		arrowhead_forward = anglestoforward(spawnpoint.angles);
		arrowhead_right = anglestoright(spawnpoint.angles);

		arrow_forward = maps\mp\_utility::vector_scale(arrow_forward, 32);
		arrowhead_forward = maps\mp\_utility::vector_scale(arrowhead_forward, 24);
		arrowhead_right = maps\mp\_utility::vector_scale(arrowhead_right, 8);
		
		a = center + arrow_forward;
		b = center + arrowhead_forward - arrowhead_right;
		c = center + arrowhead_forward + arrowhead_right;
		
		thread lineUntilNotified(center, a, (1, 1, 1), 0);
		thread lineUntilNotified(a, b, (1, 1, 1), 0);
		thread lineUntilNotified(a, c, (1, 1, 1), 0);

		thread print3DUntilNotified(spawnpoint.origin + (0, 0, 72), spawnpoint.classname, (1, 1, 1), 1, 1);
	}
}

print3DUntilNotified(origin, text, color, alpha, scale)
{
	level endon("hide_spawnpoints");
	
	for(;;)
	{
		print3d(origin, text, color, alpha, scale);
		wait .05;
	}
}

lineUntilNotified(start, end, color, depthTest)
{
	level endon("hide_spawnpoints");
	
	for(;;)
	{
		line(start, end, color, depthTest);
		wait .05;
	}
}

hideSpawnpoints()
{
	level notify("hide_spawnpoints");
}
