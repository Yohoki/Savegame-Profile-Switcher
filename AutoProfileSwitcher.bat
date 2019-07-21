::Initialize - set title and window properties
@ECHO OFF
mode con: cols=35 lines=8
:Initialize
set Game=%1
set Headed=1
if %Game%.==. goto ERROR
if %Game%==/h goto HEADLESS
call GameConfig.bat
goto OPEN
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
:END
if %Headed%==0 (
cls
type ".\%SaveFldr%\Profile.txt"
echo Profile swapped. Exiting...
ping -n 11 localhost >nul
)
exit
