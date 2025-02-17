# DeathRun 1.2 Mod for CoD4

DeathRun is a multiplayer modification in which a single player (aka. activator) uses various traps and obstacles to eliminate the other team.
Players on the opposing team (aka. jumpers) have goal to survive and kill the trapmaster.

<hr>

- Official website: http://www.moddb.com/mods/braxs-death-run-mod
- Official trailer: https://www.youtube.com/watch?v=n_YTTdQPJfk


<hr>

# Configuration & Instalation

* You should have Call of Duty 4: Modern Warfare patched to version 1.6 or 1.7
* CoD4 Mod Tools must be patched to latest version
* Some people mention that `linker_pc` is prone to crashes if the game's language isn't English
* Source files are slightly diferent from the latest official beta build from 2012, they've been retrieved from a broken hard drive.
* `"CoD4 Root"` is the directory where CoD4 is installed (where the iw3mp.exe is)

To build the mod:

1. Clone this respoitory and copy `deathrun_dev` folder to `CoD4 Root/mods`
2. Paste the contents of `raw` folder from `SP2MP.zip` to your `"CoD4 Root/raw"` and *NOT TO YOUR DEATHRUN_DEV* folder or some unused files might be then bundled with mod
3. Run `makeMod.bat` to build `mod.ff` - if this is the first compilation press `D` whenever asked (you're copying directories)
4. Run `makeIWD.bat` to build `IWD` files
5. If in doubt, `runMod.bat` should launch the game with the deathrun mod

<hr>

# Credits

- BraXi
- Bipo - For creation of Next Map Voting and Credits scripts
- Duffman - For adding missing trigger entities for "Time Record" to maps which haven't included them in first place
- |MACOM|Hacker - For conversion of L4D1 Zoey, MW2 Juggernaut, Halo Masterchief characters, and viewhands models to CoD4
- _INSANE_ - For converting Zakhaev and Farmer models to MP
- MR-X - For creation of the Main Menu background, and a logo?
- Etheross - For converting MW2 models: Shepherd, Makarov & Tomahawk, to CoD4
- Infinity Ward - For models from CoD:MW2 and the mod tools
- Authors of original Deathrun mod for CS 1.6 for idea
- And others who've spent time testing this mod and reporting bugs
- A very special thanks to mappers who've spent hours, days, and weeks to create maps for this mod...

<hr>
