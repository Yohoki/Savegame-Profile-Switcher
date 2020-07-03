::Initialize - set title and window properties, load parameters, etc.
:Initialize
@ECHO OFF
mode con: cols=35 lines=8
setlocal enabledelayedexpansion
set Headed=1
if %1%.==. goto ERROR
if %1%==/help goto ABOUT
if %1%==/a goto ADDNEW
if %1%==/h goto HEADLESS
set Game=%1
call :READINI AutoProfileSwapper.ini %Game% SaveDir SaveDir
set insection=
call :READINI AutoProfileSwapper.ini %Game% SaveFldr SaveFldr
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
::Get info from INI file
:READINI <filename> <section> <key> <result>
  set %~4=
  setlocal
  set insection=
  for /f "usebackq eol=: tokens=*" %%a in ("%~1") do (
    set line=%%a
    if defined insection (
      for /f "tokens=1,* delims==" %%b in ("!line!") do (
        if /i "%%b"=="%3" (
          endlocal
          set %~4=%%~c
          goto :eof
        )
      )
    )
    if "!line:~0,1!"=="[" (
      for /f "delims=[]" %%b in ("!line!") do (
        if /i "%%b"=="%2" (
          set insection=1
        ) else (
          endlocal
          if defined insection goto :eof
        )
      )
    )
  )
  endlocal
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
ren "%SaveFldr%" "%SaveFldr%_"
ren "%SaveFldr%Profile2" "%SaveFldr%"
ren "%SaveFldr%_" "%SaveFldr%Profile2"
if %Headed%==0 goto END
goto OPEN
::
::Headless Mode
:HEADLESS
mode con: cols=35 lines=9
set Headed=0
shift
set Game=%1
call :READINI AutoProfileSwapper.ini !Game! SaveDir SaveDir
set insection=
call :READINI AutoProfileSwapper.ini !Game! SaveFldr SaveFldr
goto OPEN
::
::Add a new GameID to Config File
:ADDNEW
::Check if GameID Exists
set Game=%2
for /f "tokens=1,* delims=[]" %%x in (AutoProfileSwapper.ini) do (
	call :IDFOUND %%x
)
::if not exists, Create!
mode con: cols=35 lines=9
echo.>>AutoProfileSwapper.ini
echo ^[%2^]>>AutoProfileSwapper.ini
echo ^:^:%2 Profile - Auto Added>>AutoProfileSwapper.ini
echo SaveDir="%3">>AutoProfileSwapper.ini
echo SaveFldr=%4>>AutoProfileSwapper.ini
cd /d %3
echo ===================================>.\%4\Profile.txt
echo        The Active Profile is>>.\%4\Profile.txt
echo ----------------------------------->>.\%4\Profile.txt
echo          Profile Name Here>>.\%4\Profile.txt
echo ----------------------------------->>.\%4\Profile.txt
echo           %2>>.\%4\Profile.txt
echo ===================================>>.\%4\Profile.txt
md %4Profile2
echo ===================================>.\%4Profile2\Profile.txt
echo        The Active Profile is>>.\%4Profile2\Profile.txt
echo ----------------------------------->>.\%4Profile2\Profile.txt
echo          Profile Name Here>>.\%4Profile2\Profile.txt
echo ----------------------------------->>.\%4Profile2\Profile.txt
echo           %2>>.\%4Profile2\Profile.txt
echo ===================================>>.\%4Profile2\Profile.txt
type .\%4\Profile.txt
echo New GameID Added!
pause
goto END
::
::Test all GameIDs vs new GameID and stop from creating again
:IDFOUND
if %Game%==%1 (
	mode con: cols=35 lines=8
	cls
	echo  =================================
	echo     Error: Game already exists!
	echo    -----------------------------
	echo    GameID = %1
	echo    Run this program without "/a"
	echo  =================================
	echo Exiting in 5 seconds...
	ping -n 6 localhost >nul
	goto END
) else ( goto :eof )
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
