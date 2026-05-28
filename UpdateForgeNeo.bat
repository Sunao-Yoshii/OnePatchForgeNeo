@echo off
if exist "%SystemRoot%\System32\chcp.com" "%SystemRoot%\System32\chcp.com" 65001 >nul

set "PROJECT_ROOT=%~dp0"
set "FORGE_DIR=%PROJECT_ROOT%sd-webui-forge-neo"
set "FORGE_VENV=%FORGE_DIR%\venv"
set "MAKE_VENV=%PROJECT_ROOT%shells\python\make_venv.bat"

if not exist "%FORGE_DIR%" (
    echo Forge Neo directory does not exist: "%FORGE_DIR%"
    exit /b 1
)

if not exist "%MAKE_VENV%" (
    echo make_venv.bat does not exist: "%MAKE_VENV%"
    exit /b 1
)

if exist "%FORGE_VENV%" (
    rmdir /s /q "%FORGE_VENV%"
    if exist "%FORGE_VENV%" (
        echo Failed to remove Forge Neo venv: "%FORGE_VENV%"
        exit /b 1
    )
)

git -C "%FORGE_DIR%" pull origin neo
if errorlevel 1 (
    echo Failed to update Forge Neo repository.
    exit /b 1
)

call "%MAKE_VENV%" "%FORGE_DIR%"
if errorlevel 1 (
    echo Failed to recreate Forge Neo venv.
    exit /b 1
)

exit /b 0
