@echo off
:depotcheck
if not exist depotdownloader.exe (
    @echo The app will not function because a core requirement depotdownloader is nonexistent
    @echo To fix this, please reinstall depotdownloader and ensure all files are in their correct places
    pause
    goto :bye
)
title EZDD Settings
set sure=nol
:choice
cls
@echo Here are the options available in this menu:
@echo 1. Cleanup depots
@echo 2. Manage AppData folder
@echo 3. Validate steamapps\common folder
@echo 4. Reinstall Dependencies
@echo 5. Reset program
@echo 6. Uninstall EZDD
set /P choice=7. Quit 
if "%choice%" EQU "1" goto :cleanup
if "%choice%" EQU "2" goto :appdata
if "%choice%" EQU "3" goto :comnvali
if "%choice%" EQU "4" goto :reinstalldep
if "%choice%" EQU "5" goto :reset
if "%choice%" EQU "6" goto :uninstall
if "%choice%" EQU "7" goto :bye
goto :choice

:cleanup
cls
set /P sure=You sure you want to delete your depots? (y/n) 
if "%sure%" EQU "y" goto :del
if "%sure%" EQU "n" goto :choice
goto :cleanup

:del
rd /s /q depots
goto :choice

:appdata
explorer.exe "%LOCALAPPDATA%\ECC\EZDD"
goto :choice

:comnvali
mkdir "%LOCALAPPDATA%\ECC\SteamDD"
cls
if not exist "%LOCALAPPDATA%\ECC\SteamDD\pa.th" (
    :svpath
    cls
    @echo The path does not seem to be saved.
    set /P svpth=Save the path? [y/n] 
    if "%svpth%" EQU "y" goto :savepath
    if "%svpth%" EQU "n" goto :choice
    goto :svpath
)

set /P steampth=<"%LOCALAPPDATA%\ECC\SteamDD\pa.th"
if not exist "%steampth%\..\..\steamapps" (
    @echo the currently saved path is not valid
    pause
    goto :svpath
)
:crctpth
cls
set /P crctpth=Is "%steampth%" the correct path? (y/n) 
if "%crctpth%" EQU "y" goto :pathsaved
if "%crctpth%" EQU "n" goto :isvalidsteampath
goto :crctpth

:savepath
if exist "C:\Program Files (x86)\Steam\steamapps" (
    @echo "C:\Program Files (x86)\Steam\steamapps\common" >> "%appdata%\..\local\ecc\steamdd\pa.th"
    goto :copy
)
:isvalidsteampath
cls
set /P p=type in your steamapps\common location now 
if not exist "%p%\..\..\steamapps" (
    @echo Please enter a valid path
    pause
    goto :isvalidsteampath
)
@echo %p% >> "%appdata%\..\local\ecc\steamdd\pa.th"

:pathsaved
@echo your steamapps\common location is now saved.
pause
goto :choice

:reinstalldep
set /P sure=Are you sure you want to reinstall dependencies? (y/n) 
if "%sure%" EQU "y" goto :reindep
if "%sure%" EQU "n" goto :choice
goto :reinstalldep

:reindep
winget install git.git
winget install dotnet-runtime-6
@echo Reinstallation complete!
pause
goto :choice

:reset
cls
@echo This will delete the data folder, it will be like you first ran the program
set /P sure=You sure you want to reset the program? (y/n) 
if "%sure%" EQU "y" goto :res
if "%sure%" EQU "n" goto :choice
goto :reset

:res
@echo Last chance before deleting
rd /s "%LOCALAPPDATA%\ECC\EZDD\"
rd /s /q "%LOCALAPPDATA%\ECC\SteamDD"
goto :bye

:uninstall
REM Fetch the latest release information from the GitHub API
for /f "tokens=2 delims= " %%a in ('curl -L -s https://api.github.com/repos/eeb7adev/ezdd/releases/latest ^| find /i "browser_download_url"') do set "download_url=%%a"

REM Download the release asset
curl -LJO %download_url%

REM Extract the release asset
powershell -Command "Expand-Archive -Path ".\*.EZDD.zip" ".\uninstall""

cd uninstall\eazydepotdownloader
setup.bat uninstallDGd8GFHEICDBd6dMP3binfhGDhd63bs8X86

:bye
if not exist "%LOCALAPPDATA%\ECC\EZDD\" (
    @echo The program has been resetted, the app will now exit.
    TIMEOUT /T 5 /NOBREAK > NUL
    exit
)
if "%1" EQU "fromapp" EZDD.bat
exit
