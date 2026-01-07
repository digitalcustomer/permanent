@echo off
setlocal ENABLEDELAYEDEXPANSION

title Permanent Redirect Auto Updater

echo =========================================
echo   PERMANENT LINK AUTO UPDATE SCRIPT
echo =========================================
echo.

:: Ask user for new link
set /p NEWURL=Enter NEW website URL (https://...): 

:: Empty check
if "%NEWURL%"=="" (
  echo.
  echo ❌ ERROR: URL empty nahi ho sakta
  pause
  exit /b
)

:: Basic URL validation
echo %NEWURL% | findstr /R /I "^https\?://" >nul
if errorlevel 1 (
  echo.
  echo ❌ ERROR: URL https:// se start hona chahiye
  pause
  exit /b
)

:: Write link to target.txt
echo %NEWURL%> target.txt

:: Git check
git --version >nul 2>&1
if errorlevel 1 (
  echo.
  echo ❌ ERROR: Git install ya configure nahi hai
  pause
  exit /b
)

:: Git commit & push
git add target.txt
git commit -m "Update redirect target"
git push

if errorlevel 1 (
  echo.
  echo ❌ ERROR: Git push fail hua (internet/login check karo)
  pause
  exit /b
)

echo.
echo ✅ SUCCESS!
echo 🔗 Redirect link safely update ho gaya
echo ⏳ GitHub Pages 30–90 seconds me update ho jayega
echo =========================================
pause
