@echo off
setlocal

title Permanent Redirect Auto Updater

echo =========================================
echo   PERMANENT LINK AUTO UPDATE SCRIPT
echo =========================================
echo.

:: Move to this script's directory (VERY IMPORTANT)
cd /d "%~dp0"

:: Ask for new URL
set /p NEWURL=Enter NEW website URL (https://...): 

:: Empty check
if "%NEWURL%"=="" (
  echo.
  echo ERROR: URL empty nahi ho sakta
  pause
  exit /b
)

:: Simple https check
if not "%NEWURL:~0,8%"=="https://" (
  echo.
  echo ERROR: URL https:// se start hona chahiye
  pause
  exit /b
)

:: Update target.txt
echo %NEWURL%> target.txt

echo.
echo Updating GitHub...

:: Always sync first
git pull origin main

:: Commit & push
git add target.txt
git commit -m "Update redirect target"
git push origin main

if errorlevel 1 (
  echo.
  echo ERROR: Git push fail hua
  echo Check internet ya GitHub login
  pause
  exit /b
)

echo.
echo ✅ SUCCESS!
echo 🔗 Redirect updated
echo ⏳ GitHub Pages 30–90 seconds me update ho jayega
echo =========================================
pause
