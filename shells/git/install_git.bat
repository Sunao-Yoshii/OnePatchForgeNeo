@echo off
setlocal

where git >nul 2>&1
if not errorlevel 1 (
    exit /b 0
)

chcp 65001 >nul

if not defined PORTABLE_GIT_VERSION (
    echo PORTABLE_GIT_VERSION is not defined.
    exit /b 1
)

set "SCRIPT_DIR=%~dp0"
set "ENV_DIR=%SCRIPT_DIR%env"
set "PORTABLE_GIT_DIR=%ENV_DIR%\PortableGit"
set "PORTABLE_GIT_BIN_DIR=%PORTABLE_GIT_DIR%\bin"
set "PORTABLE_GIT_INSTALLER=%ENV_DIR%\PortableGit.7z.exe"
set "PORTABLE_GIT_URL=https://github.com/git-for-windows/git/releases/download/v%PORTABLE_GIT_VERSION%.windows.1/PortableGit-%PORTABLE_GIT_VERSION%-64-bit.7z.exe"

if not exist "%ENV_DIR%" (
    mkdir "%ENV_DIR%"
    if errorlevel 1 (
        echo Failed to create env directory: "%ENV_DIR%"
        exit /b 1
    )
)

curl -L --fail --output "%PORTABLE_GIT_INSTALLER%" "%PORTABLE_GIT_URL%"
if errorlevel 1 (
    echo Failed to download Portable Git for Windows.
    exit /b 1
)

echo 操作せずに、そのまま Portable Git for Windows をインストールしてください。
start /wait "" "%PORTABLE_GIT_INSTALLER%" -o"%PORTABLE_GIT_DIR%" -y
if errorlevel 1 (
    echo Portable Git for Windows installer failed.
    exit /b 1
)

set "PATH=%PORTABLE_GIT_BIN_DIR%;%PATH%"

git --version >nul 2>&1
if errorlevel 1 (
    echo git command is not available: "%PORTABLE_GIT_BIN_DIR%"
    exit /b 1
)

exit /b 0
