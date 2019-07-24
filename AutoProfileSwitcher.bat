::Initialize - set title and window properties
@ECHO OFF
mode con: cols=35 lines=8
:Initialize
set Game=%1
set Headed=1
if %Game%.==. goto ERROR
if %Game%==/help goto ABOUT
if %Game%==/a goto ADDNEW
if %Game%==/h goto HEADLESS
call GameConfig.bat
goto OPEN
::
:ABOUT
mode con: cols=110 lines=28
echo Changes a game's current savegame profile, if the game does not allow such options
echo. 
echo AutoProfileSwapper.bat [^/a ^| ^/h] [GameID] [SaveDir] [SaveFldr]
echo.
echo   /a -------- Add a new game to the config file.
echo   /h -------- Headless mode. Automatically switch profiles without user interaction.
echo   GameID ---- Loads the selected Game from the Config file.
echo                  When used with /a, adds the game ID to config file.
echo   SaveDir --- Requires /a. Adds the specified folder as the location of gamesaves folder.
echo                  Example: If Game1's savedata is at C:\Games\Game1\Saves\save01.sav
echo                  SaveDir should be C:\Games\Game1
echo   SaveFldr -- Requires /a. Adds the specified folder as the target folder for creating multiple profiles.
echo               This folder contains the Savedata.
echo                  Example: If Game1's savedata is at C:\Games\Game1\Saves\save01.sav
echo                  SaveFldr should be Saves
echo.
echo Usage:
echo.
echo   AutoProfileSwapper.bat /h Game1
echo      Switches profile for Game1 without user input
echo   AutoProfileSwapper.bat Game1
echo      Displays Current profile for Game1 and Asks user if they would like to switch.
echo   AutoProfileSwapper.bat /a Game1 C:\Games\Game1 Saves
echo      Adds Game1 as a new game in config file, with savegame folder set to C:\Games\Game1\Saves
echo   AutoProfileSwapper.bat /a
echo      Gives a prompt to add a new game to the config file.
echo.
pause
cls
exit
::
::Opening error "game not found"
:ERROR
echo Error! Game %Game% not found!
echo Exiting in 5 seconds...
ping -n 6 localhost >nul
goto END
::
::Opening sequence
:OPEN
title %Game% Detected
cd /d %SaveDir%
type ".\%SaveFldr%\Profile.txt"
if %Headed%==0 goto SWAP
set/p "pro=Swap Profile? ('Y'es/'N'o) "
if %pro%==y goto SWAP
if %pro%==Y goto SWAP
if %pro%==n goto END
if %pro%==N goto END
echo Invalid choice.
goto OPEN
::
::Swapping function
:SWAP
if %Headed%==0 (
echo Swapping Profile...
ping -n 11 localhost >nul
)
ren %SaveFldr% %SaveFldr%_
ren %SaveFldr%Profile2 %SaveFldr%
ren %SaveFldr%_ %SaveFldr%Profile2
if %Headed%==0 goto END
goto OPEN
::
::Headless Mode
:HEADLESS
mode con: cols=35 lines=9
set Headed=0
shift
set Game=%1
call GameConfig.bat
goto OPEN
::
::Add a new GameID to Config File
:ADDNEW
echo ^:^:%2 Profile - Auto Added>>GameConfig.bat
echo if %%Game%%==%2 ^(>>GameConfig.bat
echo set SaveDir="%3">>GameConfig.bat
echo set SaveFldr=%4^)>>GameConfig.bat
echo ===================================>%3\%4\Profile.txt
echo        The Active Profile is>>%3\%4\Profile.txt
echo ----------------------------------->>%3\%4\Profile.txt
echo          Profile Name Here>>%3\%4\Profile.txt
echo ----------------------------------->>%3\%4\Profile.txt
echo           %2>>%3\%4\Profile.txt
echo ===================================>>%3\%4\Profile.txt
pause
type %3\%4\Profile.txt
pause
::
::Exit program
:END
if %Headed%==0 (
cls
type ".\%SaveFldr%\Profile.txt"
echo Profile swapped. Exiting...
ping -n 11 localhost >nul
)
exit
