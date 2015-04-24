init( modVersion )
{      
        spawnpoint = (550, -2200, -5300);
        lamp = (7, 1376, -4450);
        spawnlamp = (27, 1366, -4131);
        falldingsbums = (-3130, 2559, -5282);
        station = (711, -6388, -5419);
        for(;;)
        {
                players = getentarray("player", "classname");
                for(i=0; i<players.size; i++)
                {
                        if( isDefined(players[i]) && players[i].pers["team"] == "allies" && distance(spawnpoint, players[i].origin) >= 1010 && distance(falldingsbums, players[i].origin) >= 800 && distance(station, players[i].origin) >= 1500 && players[i].origin[2] <= -5270)
                                players[i] suicide();
                        if( isDefined(players[i]) && distance(lamp, players[i].origin) <= 100 )                
                                players[i] setOrigin(spawnlamp);
                }
                wait .05;
        }
}
