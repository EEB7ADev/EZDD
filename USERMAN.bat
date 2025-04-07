@echo off
title EZDD Username Management
mkdir "%LOCALAPPDATA%\ECC\EZDD\USER"
cls
@echo Hello %USERNAME%! Here are all the slots used for saving your username.
dir "%LOCALAPPDATA%\ECC\EZDD\user"
pause
:choice
cls
@echo select an option...
@echo 1. Inspect slots
@echo 2. Manage slots
@echo 3. How do I add/delete slots
set /P c=4. Return to main menu 
if "%c%" EQU "1" goto :inspect
if "%c%" EQU "2" goto :manage
if "%c%" EQU "3" goto :how
if "%c%" EQU "4" goto :bye
goto :choice

:inspect
cls
dir "%LOCALAPPDATA%\ECC\EZDD\user"
set /P slot=Select which slot, or r for return 

if "%slot%" EQU "r" goto :choice

if not exist "%LOCALAPPDATA%\ECC\EZDD\user\%slot%.txt" (
    @echo Slot %slot% doesn't exist!
    pause
    goto :inspect
)
set /P usr=<"%LOCALAPPDATA%\ECC\EZDD\user\%slot%.txt"
@echo slot %slot% is %usr%.
pause
goto :inspect


:manage
explorer.exe "%LOCALAPPDATA%\ECC\EZDD\user"
goto :choice


:how
set /P open=Do you have the managing folder open? (y/n) 
if "%open%" EQU "y" goto :xplain
if "%open%" EQU "n" goto :noopen

:noopen
@echo Ok, we will open it for you.
pause
explorer.exe "%LOCALAPPDATA%\ECC\EZDD\user"
:goto xplain

:xplain
@echo Basically all you have to do is to create a text file named a number so what slot eg. 1, 2, 99.
@echo then INSIDE that text file you must put your steam username, in lowercase.
@echo to delete just delete the text file
pause
goto :choice

:bye
if "%1" EQU "fromapp" EZDD.bat
exit
