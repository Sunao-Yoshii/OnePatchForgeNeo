@echo off
where git >nul 2>&1
if not errorlevel 1 (
    exit /b 0
)

set "SCRIPT_DIR=%~dp0"
set "PORTABLE_GIT_BIN_DIR=%SCRIPT_DIR%env\PortableGit\bin"

if not exist "%PORTABLE_GIT_BIN_DIR%" (
    echo Portable Git bin directory does not exist: "%PORTABLE_GIT_BIN_DIR%"
    exit /b 1
)

set "PATH=%PORTABLE_GIT_BIN_DIR%;%PATH%"
exit /b 0
