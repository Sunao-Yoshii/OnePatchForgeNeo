@echo off

for %%I in ("%~dp0.") do set "SCRIPT_DIR=%%~fI"
set "VERSION_CONTROL=%SCRIPT_DIR%\..\version_control.bat"

if not defined AREA_PATH goto LOAD_VERSION_CONTROL
if not defined ARIA_MAX_CONNECTION goto LOAD_VERSION_CONTROL
goto CHECK_SETTINGS

:LOAD_VERSION_CONTROL
if not exist "%VERSION_CONTROL%" (
    echo version_control.bat does not exist: "%VERSION_CONTROL%"
    exit /b 1
)

call "%VERSION_CONTROL%"
if errorlevel 1 (
    echo Failed to load version control settings.
    exit /b 1
)

:CHECK_SETTINGS

if not defined AREA_PATH (
    echo AREA_PATH is not defined.
    exit /b 1
)

if not defined ARIA_MAX_CONNECTION (
    echo ARIA_MAX_CONNECTION is not defined.
    exit /b 1
)

if "%~1"=="" (
    echo DOWNLOAD_DIR is required.
    exit /b 1
)

if "%~2"=="" (
    echo DOWNLOAD_FILE is required.
    exit /b 1
)

if "%~3"=="" (
    echo DOWNLOAD_URL is required.
    exit /b 1
)

set "DOWNLOAD_DIR=%~1"
set "DOWNLOAD_FILE=%~2"
set "DOWNLOAD_URL=%~3"
set "ARIA_EXE=%SCRIPT_DIR%\env\%AREA_PATH%\aria2c.exe"

if not exist "%ARIA_EXE%" (
    echo aria2c.exe does not exist: "%ARIA_EXE%"
    exit /b 1
)

:TRIM_DOWNLOAD_DIR
if "%DOWNLOAD_DIR:~-1%"=="\" (
    set "DOWNLOAD_DIR=%DOWNLOAD_DIR:~0,-1%"
    goto TRIM_DOWNLOAD_DIR
)

echo "Start download %DOWNLOAD_URL% to %DOWNLOAD_DIR%/%DOWNLOAD_FILE%"

"%ARIA_EXE%" --console-log-level=warn --file-allocation=none --check-certificate=false --disable-ipv6 -x%ARIA_MAX_CONNECTION% -d "%DOWNLOAD_DIR%" -o "%DOWNLOAD_FILE%" %DOWNLOAD_URL%
exit /b %ERRORLEVEL%
