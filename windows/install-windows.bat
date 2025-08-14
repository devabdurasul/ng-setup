@echo off
echo 🚀 Starting Angular & Node.js Installer for Windows...
echo ------------------------------------------

where pwsh >nul 2>&1
if %errorlevel% equ 0 (
    pwsh -NoProfile -ExecutionPolicy Bypass -File "%~dp0install.ps1"
    goto end
)

where powershell >nul 2>&1
if %errorlevel% equ 0 (
    powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0install.ps1"
    goto end
)

echo ❌ No PowerShell found.
echo Please install PowerShell from:
echo   https://github.com/PowerShell/PowerShell

:end
echo.
pause
