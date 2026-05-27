@echo off

if "%~1"=="" (
    echo LINK_DIR is required.
    exit /b 1
)

if "%~2"=="" (
    echo TARGET_DIR is required.
    exit /b 1
)

for %%I in ("%~1") do set "LINK_DIR=%%~fI"
for %%I in ("%~2") do set "TARGET_DIR=%%~fI"
for %%I in ("%LINK_DIR%\..") do set "LINK_PARENT_DIR=%%~fI"

if not exist "%TARGET_DIR%" (
    echo Target directory does not exist: "%TARGET_DIR%"
    exit /b 1
)

if not exist "%LINK_PARENT_DIR%" (
    mkdir "%LINK_PARENT_DIR%"
    if errorlevel 1 (
        echo Failed to create parent directory: "%LINK_PARENT_DIR%"
        exit /b 1
    )
)

if exist "%LINK_DIR%" (
    rmdir "%LINK_DIR%" >nul 2>&1
    if errorlevel 1 (
        echo Link path already exists and could not be replaced safely: "%LINK_DIR%"
        exit /b 1
    )
)

mklink /D "%LINK_DIR%" "%TARGET_DIR%" >nul 2>&1
if errorlevel 1 (
    mklink /J "%LINK_DIR%" "%TARGET_DIR%" >nul 2>&1
    if errorlevel 1 (
        echo Failed to create symbolic link or junction: "%LINK_DIR%" -^> "%TARGET_DIR%"
        exit /b 1
    )
)

exit /b 0
