::Initialize - set title and window properties
@ECHO OFF
mode con: cols=35 lines=8
:Initialize
set Game=%1
if %Game%.==. goto ERROR
if %Game%==/h goto HEADLESS
goto %Game%
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
set Headed=0
shift
set Game=%1
goto %Game%
:END
if %Headed%==0 (
cls
type ".\%SaveFldr%\Profile.txt"
echo Profile swapped. Exiting...
ping -n 11 localhost >nul
)
exit
::
::Debug1 Profile
:Debug1
set SaveDir="C:\DEBUG1"
set SaveFldr=test
goto OPEN
::
::Debug2 profile
:Debug2
set SaveDir="C:\DEBUG2"
set SaveFldr=test
goto OPEN
::
::FarCry5 Profile
:FarCry5
set SaveDir="C:\Program Files (x86)\Ubisoft\Ubisoft Game Launcher\savegames\"
set SaveFldr=FarCry5
goto OPEN
::
::Planet Coaster Profile
:PlanetCoaster
set SaveDir="C:\Users\Yohoki\Saved Games\Frontier Developments\Planet Coaster\76561197993333907\"
set SaveFldr=Saves
Goto OPEN
