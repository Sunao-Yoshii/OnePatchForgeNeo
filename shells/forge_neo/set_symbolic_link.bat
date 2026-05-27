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

if not exist "%LINK_PARENT_DIR%" (
    mkdir "%LINK_PARENT_DIR%"
    if errorlevel 1 (
        echo Failed to create parent directory: "%LINK_PARENT_DIR%"
        exit /b 1
    )
)

if not exist "%TARGET_DIR%" (
    mkdir "%TARGET_DIR%"
    if errorlevel 1 (
        echo Failed to create target directory: "%TARGET_DIR%"
        exit /b 1
    )
)

if exist "%LINK_DIR%" (
    rmdir "%LINK_DIR%" >nul 2>&1
    if exist "%LINK_DIR%" (
        robocopy "%LINK_DIR%" "%TARGET_DIR%" /E >nul
        if errorlevel 8 (
            echo Failed to copy existing link directory contents: "%LINK_DIR%" -^> "%TARGET_DIR%"
            exit /b 1
        )

        rmdir /s /q "%LINK_DIR%" >nul 2>&1
        if exist "%LINK_DIR%" (
            echo Warning: link path could not be removed, so symbolic link was skipped: "%LINK_DIR%"
            exit /b 0
        )
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
