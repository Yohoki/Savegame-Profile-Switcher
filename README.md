# Savegame Profile Switcher
Simple .bat file for use with Launchbox to switch savegames for games that don't allow multiple profiles.

# Usage
## Launchbox
> Launchbox Prep
- Add "Profile.txt" file to your Savegame Folder
- Right Click on your prefered game and click "Edit"
- Click "Additional Apps" tab and "Add Application..."
- Give it a name, like "Profile Swapper" to appear in the game's right click menu
- Click browse and add the .bat as the application.
- Set the command line parameters for your game (FarCry5, for example... no spaces allowed)
> Running in Launchbox
- Right Click your game and click the "Profile Swapper" option in the menu.
- Follow onscreen prompts.

## As a Windows Shortcut
- Add "Profile.txt" file to your Savegame Folder
- Right click on a folder and select "New->Shortcut"
- Add the Profile swapper .bat file as the target for the shortcut.
- Right click the new shortcut and click "Properties"
- Under "Target" add your command line parameters after the filename (D:\Games\AutoProfileSwapper.bat /h FarCry5, for example)
- Open shortcut and follow onscreen instructions.

# Commandline Parameters
- GameName1
  - Loads GameName1's current profile and asks if you want to swap profiles.
- /h GameName1
  - Loads GameName1's Current profile and automatically swaps profiles after 10 seconds. Great for computers lacking mouse/keyboard. Can be exited early by closing the prompt.

# Currently Supported Games
Name of game === Commandline Parameter
- Assassin's Creed: Odyssey === ACOdyssey
- Far Cry 5 === FarCry5
- Planet Coaster === PlanetCoaster

# Adding New Games
Currently, the only way to add new games to the list is to manually add these lines to the GameConfig.bat file. (right click->Edit)
~~~
::Debug1 Profile
if %Game%==Debug1 (
set SaveDir="C:\DEBUG1"
set SaveFldr=test)
~~~
- 1st line is optional, it is just a comment to help keep track of games and will be removed later as I develop the app.
- 2nd line is the name of the Commandline Parameter you want, for example Far Cry 5's is FarCry5. No spaces allowed here.
  - if %Game%==FarCry5
- 3rd line is the folder above your savegame folder.
  - If your savegame is "C:/game/savefolder/save.txt" it should say:
  - set SaveDir="C:\Game"
- 4rd line is the savegame folder's name.
  - If your savegame file is "C:/game/savefolder/save.txt" it should say:
  - set SaveFldr=savefolder)
