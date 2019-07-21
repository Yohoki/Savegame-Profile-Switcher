::Debug1 Profile
if %Game%==Debug1 (
set SaveDir="C:\DEBUG1"
set SaveFldr=test )
::Debug2 profile
if %Game%==Debug2 (
set SaveDir="C:\DEBUG2"
set SaveFldr=test )
::FarCry5 Profile
if %Game%==FarCry5 (
set SaveDir="C:\Program Files (x86)\Ubisoft\Ubisoft Game Launcher\savegames\"
set SaveFldr=FarCry5 )
::Planet Coaster Profile
if %Game%==PlanetCoaster (
set SaveDir="C:\Users\%userprofile%\Saved Games\Frontier Developments\Planet Coaster\76561197993333907\"
set SaveFldr=Saves )
::Assassin's Creed: Odyssey Profile
if %Game%==ACOdyssey (
set SaveDir="C:\Program Files (x86)\Ubisoft\Ubisoft Game Launcher\savegame\<UplayID>\5059"
set SaveFldr=saves )
