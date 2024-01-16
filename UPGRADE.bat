@echo off
:depotcheck
if not exist depotdownloader.exe (
    @echo The app will not function because a core requirement depotdownloader is nonexistent
    @echo To fix this, please reinstall depotdownloader and ensure all files are in their correct places
    pause
    goto :bye
)
REM load current version
set /P cver=<"version.txt"

REM download and load new version
git clone https://github.com/eeb7adev/ezdd

cd ezdd
set /P nver=<"version.txt"

cd..
REM Check the version
cls
if %cver% GTR %nver% goto :time
if %cver% EQU %nver% goto :latest
if %cver% LSS %nver% goto :new
REM Displays data
:time
@echo woah woah WOAH, are you a time traveler? you have a version thats newer than the latest version! As if thats possible...
pause
goto :bye

:latest
@echo You are on the latest version!
pause
goto :bye

:new
@echo A new version is available!
REM insert download here
:upgr
set /P upgrade=Do you want to upgrade? (Y/N) 
if "%upgrade%" EQU "y" goto :yes
if "%upgrade%" EQU "n" goto :bye
cls
goto :upgr

:yes
REM Fetch the latest release information from the GitHub API
for /f "tokens=2 delims= " %%a in ('curl -L -s https://api.github.com/repos/eeb7adev/ezdd/releases/latest ^| find /i "browser_download_url"') do set "download_url=%%a"

REM Download the release asset
curl -LJO %download_url%

REM Extract the release asset
powershell -Command "Expand-Archive -Path ".\*.EZDD.zip" ".\upgrade""

cd upgrade\eazydepotdownloader
setup.bat upgradehf8HEW8nWin328HEVCBDS0

goto :bye

:bye
rd /s /q ezdd REM cleanup and exit
if "%1" EQU "fromapp" EZDD.bat
exit
