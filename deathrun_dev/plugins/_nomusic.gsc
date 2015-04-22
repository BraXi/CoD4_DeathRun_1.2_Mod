init( modVersion )
{
    thread onIntermission();

    level waittill( "round_ended" );
    ambientStop( 0 );
}

onIntermission()
{
    level waittill( "intermission" );
    ambientStop( 0 );
} 
