@echo off
title EZDD for SteamRE/depotdownloader

if exist "%LOCALAPPDATA%\ECC\EZDD\clean.up" (
    @echo cleaning up...
    rd /s /q upgrade
    rd /s /q uninstall
    rd /s /q ezdd
    DEL *.EZDD.zip
    DEL "%LOCALAPPDATA%\ECC\EZDD\clean.up"
    timeout /T 5 /NOBREAK >nul
)

if not exist "%LOCALAPPDATA%\ECC\EZDD\first.launch" (
    mkdir "%LOCALAPPDATA%\ECC\EZDD\"
    cls
    @echo This file's existence means that you have read the readme and launched the app for the first time >> "%LOCALAPPDATA%\ECC\EZDD\first.launch"
    @echo A readme file will be displayed.
    pause
    cls
    @echo EZ DD aka Easy Depot Downloader readme
    @echo This is NOT a clone of SteamRE/depotdownloader. It is an addon to make things easier.
    @echo This project is in no way affiliated with the people at SteamRE.
    pause
    cls
    @echo PASSWORD NOTICE
    @echo we found out that the best way to keep your password safe is to
    @echo keep it inside a human brain, meaning we do not save your password.
    @echo we do keep your username tho, just so you dont have to type it in.
    pause
    cls
)
:depotcheck
if not exist depotdownloader.exe (
    @echo The app will not function because a core requirement depotdownloader is nonexistent
    @echo To fix this, please reinstall depotdownloader and ensure all files are in their correct places
    pause
    goto :bye
)
DEL "%LOCALAPPDATA%\ECC\EZDD\loca.tion"
@echo %cd% >> "%LOCALAPPDATA%\ECC\EZDD\loca.tion"
:choice
title Easy Depot Downloader
cls
@echo Welcome to the main menu of EZDD!
@echo Choose an option
@echo 1. Download a game
@echo 2. Move and activate a game
@echo 3. Revert depot download
@echo 4. User Management
@echo 5. What is Steam activation?
@echo 6. Settings
@echo 7. Check for updates
set /P choice=8. Quit 
if "%choice%" EQU "1" SteamDD.bat fromapp
if "%choice%" EQU "2" COPYGAME.bat fromapp
if "%choice%" EQU "3" REVERT.bat fromapp
if "%choice%" EQU "4" USERMAN.bat fromapp
if "%choice%" EQU "5" SVX.bat fromapp
if "%choice%" EQU "6" SETTINGS.bat fromapp
if "%choice%" EQU "7" UPGRADE.bat fromapp
if "%choice%" EQU "8" goto :bye
if not exist SteamDD.bat (
    goto :error
)
if not exist COPYGAME.bat (
    goto :error
)
if not exist USERMAN.bat (
    goto :error
)
if not exist SVX.bat (
    goto :error
)
if not exist SETTINGS.bat (
    goto :error
)
if not exist UPGRADE.bat (
    goto :error
)

goto :choice

:error
cls
@echo Sorry, we couldnt launch that app because it doesnt exist.
@echo You can fix this by attempting to upgrade the app.
@ehco if this doesnt work, you can try resinstalling the program at https://github.com/eeb7adev/ezdd
pause
goto :choice

:bye
@echo Bye!
timeout /T 1 /NOBREAK > nul