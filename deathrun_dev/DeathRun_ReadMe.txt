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
// 
// BraXi's Death Run Mod
// (c) 2010-2020 Paulina Sokołowska
//
// Version: 1.2.1 (02/2020)
// 
// https://www.moddb.com/mods/braxs-death-run-mod
// 
// Twitter: https://twitter.com/TheBraXi
// GitHub: https://github.com/BraXi/
// 
// E-mail: paulinabraxi somewhere at gmail.com
// 



The classical mod in which a single player fights alone against the other team, 
his only weapons are his deadly traps. The players in the opposite team have 
to kill the trapmaster after finishing his course without dying.


================================================================
================================================================

 Change log:

1.2.1:
Updated contact details.

1.2:

[F] Diferent view models (hands) for characters
[F] Unlock popups are now showing correct items
[F] Menus show correctly in widescreen resolutions
[F] A few itemDefs were moved for a better placement in menu
[F] A possible out-of-index crash when hacking certain stats in user's profile

[+] New main menu
[+] 3 more weapons
[+] Duke nukem character
[+] "Play on |BW| DeathRun server!" button
[+] More ranks

================================

1.2 BETA [28.09.2012]:

[+] Abilities
[+] Two new characters
[+] Five new sprays
[+] Player Cards
[+] Time records
[+] Challenges
[+] Damage modifiers
[+] Message of the day
[+] Added nine more ranks, maximum rank is now 30
[+] Easter egg :)
[+] Weapon damage modifiers
[+] Redesigned HUD
[+] One new weapon - Colt Anaconda .44
[+] Insertion
[+] More dvars to configure server
[+] Customizable server logo
[+] Characters have diferent hands (atleast half of them...)

[C] Less EXP in free run rounds
[C] A better anti rank hack system
[C] Changed administration access system
[C] Redesigned menus *I hope You enjoy them*

[-] Removed spray names and theirs descriptions
[-] Removed dvar "dr_pickingsystem", might come back in v1.3...

[F] Fixed overlaping sounds when maps have custom music
[F] Fixed bug allowing players to respawn at any time
[F] Fixed other various bugs

I think i forgot something this time, remind me if you find something that should be listed here ^^ 

================================

1.1 HOTFIX (1.1+) [02.02.2012]:

[+] Help menu
[+] Player guid is now shown in admin menu

[C] Rcon command "wtf" has now explosion
[C] ACP command is now bindable from options menu

[F] Teleport command works in ACP
[F] Plugins load correctly
[F] Life icons are now displayed in correct position on the screen
[F] Fixed bug with selecting players in ACP

================================

1.1 [26.01.2012]:

[+] Added new option for free run (activator can't call free run if he already used trap) [see deathrun.cfg]	
[+] Activator gets +5 Xp for activating trap [see deathrun.cfg]
[+] Activator gets +10 Xp for every jumper killed with trap or world
[+] Added hud item showing current round
[+] Current round is now shown on the screen as well as lifes and alive jumpers
[+] Fully implemented lifes system
[+] Added option to load plugins (custom scripts)
[+] Added map's records
[+] Added 3 new playable characters
[+] 21 diferent sprays total
[+] Added weapon unlocks
[+] Player bodies explode in some cases
[+] Added events such as first blood and last alive jumper
[+] New rcon command "wtf"
[+] Added admin menu and permission levels to administration system

[C] Redesigned best players board
[C] Changed method of picking activator so everyone should be, atleast once, picked to be activator during map
[C] Deaths in 1st (free run) round are not counted (if there's freerun round enabled)
[C] Traps cannot be activated by Jumpers
[C] Spray names are now editable in file "dr_sprays.cfg" inside deathrun.iwd
[C] Up to 10 end round songs in MP3 format, their names are displayed in-game and can be changed in file "dr_songs.cfg" 


[F] Fixed crash exploit in playerDisconnect() function
[F] Fixed crash exploit after restarting round or game via admin command "adm restart"
[F] Fixed troubles in core that restricted spawn in some cases when there was only 1 player on server
[F] Fixed problems with picking activator, this will solve problem with two or more activators
[F] Fixed crash exploits, every player was able to crash linux server runing Death Run
[F] Map image in main in-game menu is now shown correctly
[F] 'Probably' fixed problem with lag jump glitches, thanks to mnaauuu for this fix
[F] Fixed security hole allowing players to select any spray they want without unlocking it first

================================

1.02 [08.05.2011]:

[+] Added client side command "openScriptMenu dr whois:<nick>" displaying info about picked player
[+] Added client side command "openScriptMenu dr admins" showing list of online admins
[+] Added client side commands "openScriptMenu 2don/2doff" to enable/disable hud elements
[C] Inluded missing dvars to deathrun.cfg
[F] Fixed little bug

================================

1.01 [29.04.2011]:

[F] Fixed crash exploit in admin command "spawn"
[F] Added fix for mp_deathrun_portal
[F] Fixed "rw" admin command

================================

1.0 [25.04.2011] (FIRST PUBLIC RELEASE):

[+] Added normal bunny hooping
[+] Added more dvars
[+] In admin tools you can select player by name [ex. \rcon set adm "warn:brax:test"]
[+] Added "kill" option to AFK monitor
[+] New messaging system
[+] Added "admin" group, players will see "ADMIN" text above admin's head
[+] Admins are automatically logged to rcon
[+] Redesigned main in-game menu
[+] More statistics are now displayed in "player info" menu

[C] Knife is back for jumpers
[C] Third person camera re-enabled at the end of round (in previous version removed)
[C] End round sounds can be turned off now

[F] Fixed bug in 'best players board' showing best player with most kills but should display player with highest score
[F] Fixed engine bug that allowed to kill through wall
[F] Fixed 'elevator glitch' while pro bunny hooping
[F] Fixed some little bugs...
[F] Included fixed scripts for maps: mp_deathrun_grassy, mp_deathrun_short_v3 & mp_dr_bananaphone
[F] Fixed admin command "bounce"
[F] Fixed player info box in "Rank & Challenges" menu
[F] Fixed possible bug in ranks

================================

0.9 beta:

[+] Added pro bunny hooping (not fully implemented yet)
[+] Activator can choose FREE RUN round.
[+] Added player menu with options such as "Toggle 3rd Person Camera", "Suicide" and ability to join other server(s)
[+] Added new abilities for mappers, see http://www.braxi.org/forum/viewtopic.php?f=44&t=211
[+] Added more admin commands, see admin_tools.txt for help
[+] Added message showing who killed activator
[+] New hand model
[+] Added new characters such as: Masterchief & Juggernaut
[+] Replaced knife with tomahawk
[+] Changed map names in map voting, for example. "Dungeon" instread "mp_deathrun_dungeon"

[C] Free run round starts with 1 player
[C] AFK monitor will not check Activator
[C] Rewritten code marked as "TEMP" for better pings and to keep scripts clean
[C] Replaced "player connected." with "player entered the game"
[C] Changed "best players board" at the end of game
[C] Added 2 seconds delay when switching game state from "playing" to "end map" to display who killed activator
[C] Moved "alive jumpers" & clock under health bar
[C] Permamently disabled bullet penetration

[F] Included various fixes for maps: mp_deathrun_supermario, mp_deathrun_short & mp_deathrun_short_v2
[F] Removed features that never worked due to engine limitations
[F] Fixed bug that displayed "player disconnected." message two times
[F] Fixed crash issues
[F] Fixed bug that allowed to kill activator before round have been started
[F] Fixed very strange bug that caused some features not working after respawn
[F] Fixed 3rd person camera as spectator after end of round
[F] At the end of map players cannot move when "best players board" is shown
[F] Fixed some small bugs

================================

0.8 alpha:

[+] Added dvars to control spray's delay and ability to restrict them on server
[C] Removed bullet penetration

[F] Jumpers couter is not drawn in free run anymore
[F] Fixed bug that crashed server due to undefined guid, this happened only one time
[F] Fixed problem with lag spike when switching back to team selection menu from character setup

================================

0.7 alpha:

[+] Added new character
[+] Added 12 sprays
[+] Added new menu for character/spray selection
[+] Activator gets +25XP for being picked & another 25XP when all jumpers die
[+] Added health bar
[+] Added hud that shows how many alive jumpers left
[+] Added one new end round song

[F] Scores are now saved between round restarts
[F] Change to SAS character works now
[F] Mod will kick AFK players even if their connection is interrupted.
[F] Fixed bug in "caulk" material that allowed to kill activator on maps that use "caulk" as glass.
[F] Blocked glitches on mp_deathrun_long

================================

0.6 alpha:

[+] New, but not final, main menu
[+] Added new characters that can be unlocked [Thanks to INSANE and |MACOM|Hacker for models]
[+] Added next map voting [Again thanks to Bipo, he finished his own map voting before me ^^]
[+] Players now see how many spectators are watching them

[C] Changed log strings to work with Rcon Tools and B3 bot...
[C] Clock looks much more better now

[F] Fixed bug that caused map restart when server should change to next map
[F] Fixed round not ending in some cases
[F] Cleaned and sorted code alot
[F] Anti rank hacking check really works now
[F] Fixed little bugs...

================================

0.5 alpha:

[+] Added check if rank was hacked and will restart player's rank if so... [Thanks to Bipo]
[+] Added time limit
[+] Added messages and timer

[C] Changed round start
[C] Death players may respawn in free run round
[C] Activators have now night vision in inventory

[F] Fixed some problems with XP bar [Thanks to Bipo]
[F] Fixed some bugs that affected gameplay
[F] Fixed AFK monitor temporary banning players
[F] Included various fixes for map "mp_deathrun_long"

================================

0.4 alpha:

[+] Added xp bar
[+] Added admin commands
[+] Added welcome messages
[+] Added status icons
[+] Added "Free Run" round
[+] Added support for vision files
[+] At the end of map game will display best players
[+] Added more music
[+] Added AFK monitor

[C] Spectator wont be picked to be the activator
[C] Player that was picked in last round wont be picked in next one

[F] Fixed hint strings not showing due to hardcore hud
[F] Fixed problem with game freezing caused by a player leaving game when only 2 players were on server
[F] Fixed issues with missing team icons
[F] Fixed "xxx connected." message showing every round restart


================================================================
================================================================


 Credits:

*	BraXi - This mod.
	Xfire: braxpl

*	Bipo - Map Voting and Credits scripts.
	Xfire: bipoalarmonk

*	Duffman - Helping me with time triggers for "Time Records" feature
	Xfire: mani96x

*	|MACOM|Hacker - Rigging: Zoey, Juggernaut, masterchief and new hands.
	Xfire: 05hepburn
	
*	_INSANE_ - Converted Zakhaev and Farmer from SP to MP.
	Xfire: undertakerhs

*	MR-X - Main Menu background.
	Xfire: mousasalem

*	Etheross - Converted Shepherd, Makarov & Tomahawk to CoD4.
	Xfire: etheross




THIS MATERIAL IS NOT MADE OR SUPPORTED BY ACTIVISION.