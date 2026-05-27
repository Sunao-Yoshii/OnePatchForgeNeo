@echo off

for %%I in ("%~dp0.") do set "SCRIPT_DIR=%%~fI"
set "VERSION_CONTROL=%SCRIPT_DIR%\..\version_control.bat"

if not defined AREA_DOWNLOAD_URL (
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

if not defined AREA_DOWNLOAD_URL (
    echo AREA_DOWNLOAD_URL is not defined.
    exit /b 1
)

if not defined AREA_PATH (
    echo AREA_PATH is not defined.
    exit /b 1
)

set "ENV_DIR=%SCRIPT_DIR%\env"
set "ARIA_ZIP=%ENV_DIR%\aria2.zip"
set "ARIA_DIR=%ENV_DIR%\%AREA_PATH%"
set "ARIA_EXE=%ARIA_DIR%\aria2c.exe"

if not exist "%ENV_DIR%" (
    mkdir "%ENV_DIR%"
    if errorlevel 1 (
        echo Failed to create download env directory: "%ENV_DIR%"
        exit /b 1
    )
)

curl -L --fail --ssl-no-revoke --output "%ARIA_ZIP%" "%AREA_DOWNLOAD_URL%"
if errorlevel 1 (
    echo Failed to download aria2: "%AREA_DOWNLOAD_URL%"
    exit /b 1
)

tar -xf "%ARIA_ZIP%" -C "%ENV_DIR%"
if errorlevel 1 (
    echo Failed to extract aria2 archive: "%ARIA_ZIP%"
    exit /b 1
)

if not exist "%ARIA_EXE%" (
    echo aria2c.exe does not exist: "%ARIA_EXE%"
    exit /b 1
)

exit /b 0
