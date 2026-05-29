@echo off
if exist "%SystemRoot%\System32\chcp.com" "%SystemRoot%\System32\chcp.com" 65001 >nul

for %%I in ("%~dp0.") do set "PROJECT_ROOT=%%~fI"
set "FORGE_DIR=%PROJECT_ROOT%\sd-webui-forge-neo"
set "FORGE_VENV=%FORGE_DIR%\venv"
set "MAKE_VENV=%PROJECT_ROOT%\shells\python\make_venv.bat"
set "SET_GIT_PATH=%PROJECT_ROOT%\shells\git\set_git_path.bat"

if not exist "%FORGE_DIR%" (
    echo Forge Neo directory does not exist: "%FORGE_DIR%"
    exit /b 1
)

if not exist "%MAKE_VENV%" (
    echo make_venv.bat does not exist: "%MAKE_VENV%"
    exit /b 1
)

if not exist "%SET_GIT_PATH%" (
    echo set_git_path.bat does not exist: "%SET_GIT_PATH%"
    exit /b 1
)

call "%SET_GIT_PATH%"
if errorlevel 1 (
    echo Failed to set git path.
    exit /b 1
)

pushd "%PROJECT_ROOT%"
if errorlevel 1 (
    echo Failed to enter OnePatchForgeNeo repository: "%PROJECT_ROOT%"
    exit /b 1
)

git pull origin main
set "PROJECT_PULL_RESULT=%ERRORLEVEL%"
popd

if not "%PROJECT_PULL_RESULT%"=="0" (
    echo Failed to update OnePatchForgeNeo repository.
    exit /b 1
)

if exist "%FORGE_VENV%" (
    rmdir /s /q "%FORGE_VENV%"
    if exist "%FORGE_VENV%" (
        echo Failed to remove Forge Neo venv: "%FORGE_VENV%"
        exit /b 1
    )
)

pushd "%FORGE_DIR%"
if errorlevel 1 (
    echo Failed to enter Forge Neo repository: "%FORGE_DIR%"
    exit /b 1
)

git pull origin neo
set "FORGE_PULL_RESULT=%ERRORLEVEL%"
popd

if not "%FORGE_PULL_RESULT%"=="0" (
    echo Failed to update Forge Neo repository.
    exit /b 1
)

call "%MAKE_VENV%" "%FORGE_DIR%"
if errorlevel 1 (
    echo Failed to recreate Forge Neo venv.
    exit /b 1
)

exit /b 0
