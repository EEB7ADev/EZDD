@echo off
title Revert Downgrade
@echo This will not delete the old version, it will archive it by renaming it to "[GAME]OLD"
pause
mkdir "%LOCALAPPDATA%\ECC\SteamDD"
cls
if exist "%appdata%\..\local\ecc\steamdd\pa.th" (
    goto :revert
)
cls
if exist "C:\Program Files (x86)\Steam\steamapps" (
    @echo "C:\Program Files (x86)\Steam\steamapps\common">> "%appdata%\..\local\ecc\steamdd\pa.th"
    goto :revert
)
:isvalidsteampath
cls
set /P p=Your steamapps location has not yet been saved, type in your steamapps\common location now 
if not exist "%p%\..\..\steamapps" (
    @echo Please enter a valid path
    pause
    goto :isvalidsteampath
)
@echo %p%>> "%appdata%\..\local\ecc\steamdd\pa.th"

:revert
set /P spath=<"%appdata%\..\local\ecc\steamdd\pa.th"
cd /d "%spath%"
@echo We will now open the steamapps folder
pause
start .
:game
cls
set /P game=In the folder we opened, look to find the game you want to revert back to the current version and type it in here. You can also type in b if you change your mind and want to go back. 
if "%game%" EQU "b" goto :bye
if not exist "%game%CURRENT" (
    @echo this game does not exist or it has not been replaced with an old version
    pause
    goto :game
)
@echo Reverting game...
rename "%game%" "%game%OLD"
rename  "%game%CURRENT" "%game%"
timeout /t 2 /nobreak > nul
@echo As you might know, reverting to old and newer versions of games require validation.
@echo We will do the process for you.
pause
cd "%game%"
:exenm
cls
dir *.exe
@echo shown above is the directory of the depot downloaded game
set /P exenm=Please type in the executable name of which launches the game, or if the exe is in a subfolder, type in "subfolder" without quotes 
if "%exenm%" EQU "subfolder" goto :subfolder
if not exist "%exenm%.exe" (
    @echo This exe does not exist, please enter a valid exe
    pause
    goto :exenm
)
cls
title instruction on Validation
@echo the game will now launch
@echo please wait for the game to be reopned by steam, when that happens, steam validation is a success
@echo if you are confused, please select the "What is Steam Activation in the main menu"
@echo please note that some games will not require validation, but will be launched anyways
pause
%exenm%
exit

:subfolder
cls
@echo The game folder will now open, please launch the executable to complete the validation progress, the application will now quit.
pause
start .
exit

:bye
set /P ezpath=<"%appdata%\..\local\ecc\ezdd\loca.tion"
cd /d "%ezpath%"

if "%1" EQU "fromapp" EZDD.bat
exit
