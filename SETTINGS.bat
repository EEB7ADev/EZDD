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
@echo 2. Reset program
@echo 3. Uninstall EZDD
set /P choice=4. Quit 
if "%choice%" EQU "1" goto :cleanup
if "%choice%" EQU "2" goto :reset
if "%choice%" EQU "3" goto :uninstall
if "%choice%" EQU "4" goto :bye
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
goto :choice

:uninstall
REM Fetch the latest release information from the GitHub API
for /f "tokens=2 delims= " %%a in ('curl -L -s https://api.github.com/repos/eeb7adev/ezdd/releases/latest ^| find /i "browser_download_url"') do set "download_url=%%a"

REM Download the release asset
curl -LJO %download_url%

REM Extract the release asset
powershell -Command "Expand-Archive -Path ".\*.EZDD.zip" ".\uninstall""

cd uninstall
cd eazydepotdownloader
setup.bat uninstallDGd8GFHEICDBd6dMP3binfhGDhd63bs8X86

:bye
if not exist "%LOCALAPPDATA%\ECC\EZDD\" (
    @echo The program has been resetted, the app will now exit.
    TIMEOUT /T 5 /NOBREAK > NUL
    exit
)
if "%1" EQU "fromapp" EZDD.bat
exit