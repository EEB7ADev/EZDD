@echo off
:depotcheck
if not exist depotdownloader.exe (
    @echo The app will not function because a core requirement depotdownloader is nonexistent
    @echo To fix this, please reinstall depotdownloader and ensure all files are in their correct places
    pause
    goto :bye
)

mkdir "%LOCALAPPDATA%\ECC\SteamDD"

cls
title Copy Downloaded game
set /P id=Enter the depot id here or type in b to quit 

if "%id%" EQU "b" goto :bye


:steampathchk
if exist "%appdata%\..\local\ecc\steamdd\pa.th" (
    goto :copy
)
cls
if exist "C:\Program Files (x86)\Steam\steamapps" (
    @echo "C:\Program Files (x86)\Steam\steamapps\common" >> "%appdata%\..\local\ecc\steamdd\pa.th"
    goto :copy
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

:copy
cls
set /P mvoract=Do you want to copy over a new game to your steamapps\common dir or re-activate an already copied game? New game or Re-activate game (n/r) 
if "%mvoract%" EQU "n" goto :newgm
if "%mvoract%" EQU "r" goto :reactvte
:newgm
title Steam Validation and copy process
set /P steampath=<"%appdata%\..\local\ecc\steamdd\pa.th"
@echo We will now open 2 directories, the first directory is your common folder
@echo the second directory is the folder the game was downloaded to
@echo in the common folder, locate the folder of the game you have downloaded.
@echo you will be prompted to enter it, it is case sensitive
@echo in the depot download folder - after you have entered the folder name
@echo rename the folder you see into the SAME FOLDER NAME
@echo if you are confused about all this, please select the "What is Steam Activation in the home menu"
pause
start %steampath%
start .\depots\%id%

:gamefolder
cls
@echo please look into the common folder for the folder name of the game you want to validate.
set /P folnm=IT IS CASE SENSITIVE 
if not exist "%steampath%\%folnm%" (
    @echo This game does not exist or may have already been copied.
    pause
    goto :gamefolder
)
@echo Please rename the folder you see in your depot downloader folder to %folnm%
@echo as soon you rename the folder, we will recase the folder and begin the validation process

:checkifrename
if not exist ".\depots\%id%\%folnm%" (
    goto :checkifrename
)
cd .\depots\%id%
rename "%folnm%" recasing
rename recasing "%folnm%"

cls
@echo Please move %folnm% to the common folder
cd /d "%steampath%"
rename "%folnm%" "%folnm%CURRENT"

:newfolchk
if not exist "%folnm%" (
    goto :newfolchk
)
@echo Please wait until the moving process has completed
pause
cls
cd "%folnm%"
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

:reactvte
title Steam Validation process
set /P steampath=<"%appdata%\..\local\ecc\steamdd\pa.th"
cls
cd /d "%steampath%"
:rgmnm
cls
set /P name=What is the game you want to re-activate? ITS CASE SENSITIVE!!! 
if not exist "%name%OLD" (
    @echo This game does not exist, or it has not been copied over yet.
    pause
    goto :rgmnm
)
rename "%name%" "%name%CURRENT"
rename "%name%OLD" "%name%"
cd "%name%"
goto :exenm

:bye
set /P ezpth=<"%LOCALAPPDATA%\ECC\EZDD\loca.tion"
if "%1" EQU "fromapp" EZDD.bat
exit
