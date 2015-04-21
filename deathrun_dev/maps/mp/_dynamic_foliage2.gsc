
///////////////////////////////////////////////////////////
// Dynamic Foliage v.1 for CoD:WaW & CoD:MW 
// Coded by Zweimann ( zweimann@helipollos.es )
// This code has been written to enhance the ingame experience,
// adding dynamic scenarios instead of static ones.
///////////////////////////////////////////////////////////
 
#include maps\mp\_utility;
#include common_scripts\utility;
 
// ---------------------------------------------------------------------
// Init Script
// ---------------------------------------------------------------------
 
initdfs()
{
println("^1Initializing Zweimann's Dynamic Foliage System");
 
// There should be three different script_models: trees, foliage and grass, because they're
// treated in a different way.
// Consider Grass to grass (obviously) and to very small foliage elements
// Consider Foliage to midsize foliage
// classname: script_model
// targetname: <name>
// These names were used in Burma 1.1. Change them to whatever you want
level.dfs_tree_sm_name = "dyn_trees";
level.dfs_foliage_sm_name = "myfoliages";
level.dfs_grass_sm_name = "mygrass";
 
// You must set up here Strength of Wind, to simulate higher or lower sway
// on foliage and trees.
// 0 means no wind @ all
// 10 means A HURRICANE : )
// Recommended values: 0.3 to 0.6. Optimal value: 0.5;
// Obviously you can setup a dvar or whatever for this
 
level.dfs_wind_strength = 0.6;
// Let's start
 
foliage_animation();
grass_animation();
tree_animation();
}
 
// -----------------------------------------------------------------
// Main Scripts
// -----------------------------------------------------------------
 
tree_animation()
{
    level endon("game_ended");
    // Sway animation for Trees
    // Slower, softer
 
    entities = getentarray( level.dfs_tree_sm_name, "targetname" );
 
    vpoint = level.dfs_wind_strength / 1.4;
    vangles = level.dfs_wind_strength / 1.5;
    vtime = ( 6 * ( 1 - level.dfs_wind_strength ) );
 
    for( i = 0; i < entities.size; i++ )
        {
            factor = randomIntRange( 0, 10 );
 
            if ( factor >= 5 )
            mmfactor = 1;
            else
            mmfactor = -1;
 
            vibvector = entities[i].origin + ( ( vpoint * mmfactor ), 0, 0 );
            entities[i] vibrate( vibvector, vangles * mmfactor , vtime, ( ( getDvarInt( "scr_timelimit" ) * 1.2 ) * 60 ) );
            wait 0.005;
        }
    }
 
foliage_animation()
{ 
level endon("game_ended");
 
// Sway animation for Foliage
// Stronger
entities = getentarray( level.dfs_foliage_sm_name, "targetname" );
vpoint = level.dfs_wind_strength * 1.5;
vangles = level.dfs_wind_strength * 2;
vtime = ( ( 1 - level.dfs_wind_strength ) ) * 5;
 
mmfactor = 1;
 
for( i = 0; i < entities.size; i++ )
{ 
mmfactor *= -1;
 
vibvector = entities[i].origin + ( randomFloatRange( 0,90 ) * mmfactor , 0, 0 );
 
entities[i] vibrate( vibvector, ( vangles * mmfactor ) , vtime, ( ( getDvarInt( "scr_timelimit" ) * 1.2 ) * 60 ) );
 
wait 0.005;
}
}
 
grass_animation()
{ 
level endon("game_ended");
 
// Sway animation for Grass
// Strongest
entities = getentarray( level.dfs_grass_sm_name, "targetname" );
 
vpoint = level.dfs_wind_strength * 2;
vangles = level.dfs_wind_strength * 4;
vtime = ( ( 1 - level.dfs_wind_strength ) ) * 2.5;
 
mmfactor = 1;
 
for( i = 0; i < entities.size; i++ )
{ 
mmfactor *= -1;
 
vibvector = entities[i].origin + ( ( vpoint * mmfactor ), 0, 0 );
 
entities[i] vibrate( vibvector, ( vangles * mmfactor ) , vtime, ( ( getDvarInt( "scr_timelimit" ) * 1.2 ) * 60 ) );
 
wait 0.005;
}
}
 
