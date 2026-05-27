@echo off

set "SCRIPT_DIR=%~dp0"
set "VERSION_CONTROL=%SCRIPT_DIR%..\version_control.bat"

if not defined PYTHON_VERSION (
    if not exist "%VERSION_CONTROL%" (
        echo version_control.bat does not exist: "%VERSION_CONTROL%"
        exit /b 1
    )

    call "%VERSION_CONTROL%"
    if errorlevel 1 (
        echo Failed to load version control settings.
        exit /b 1
    )
)

if not defined PYTHON_VERSION (
    echo PYTHON_VERSION is not defined.
    exit /b 1
)

if not defined PYTHON_PATH (
    echo PYTHON_PATH is not defined.
    exit /b 1
)

where python >nul 2>&1
if errorlevel 1 goto SET_LOCAL_PYTHON_PATH

for /f "tokens=2" %%V in ('python --version 2^>^&1') do set "CURRENT_PYTHON_VERSION=%%V"
call set "CURRENT_PYTHON_PREFIX=%%CURRENT_PYTHON_VERSION:~0,4%%"
if "%CURRENT_PYTHON_PREFIX%"=="%PYTHON_VERSION%" (
    exit /b 0
)

:SET_LOCAL_PYTHON_PATH

set "PYTHON_DIR=%SCRIPT_DIR%%PYTHON_PATH%"
set "PYTHON_SCRIPTS_DIR=%PYTHON_DIR%\Scripts"

if not exist "%PYTHON_DIR%" (
    echo Python directory does not exist: "%PYTHON_DIR%"
    exit /b 1
)

call set "PATH=%PYTHON_DIR%;%PYTHON_SCRIPTS_DIR%;%%PATH%%"
exit /b 0
