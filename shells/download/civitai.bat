@echo off

if "%~1"=="" (
    echo DOWNLOAD_DIR is required.
    exit /b 1
)

if "%~2"=="" (
    echo DOWNLOAD_FILE is required.
    exit /b 1
)

if "%~3"=="" (
    echo MODEL_ID is required.
    exit /b 1
)

for %%I in ("%~dp0.") do set "SCRIPT_DIR=%%~fI"
for %%I in ("%~dp0..\..") do set "PROJECT_ROOT=%%~fI"
set "ARIA_BAT=%SCRIPT_DIR%\aria.bat"
set "READ_CIVITAI_KEY=%PROJECT_ROOT%\shells\forge_neo\read_civitai_key.bat"

if not exist "%ARIA_BAT%" (
    echo aria.bat does not exist: "%ARIA_BAT%"
    exit /b 1
)

if not defined CIVITAI_KEY (
    if not exist "%READ_CIVITAI_KEY%" (
        echo read_civitai_key.bat does not exist: "%READ_CIVITAI_KEY%"
        exit /b 1
    )

    call "%READ_CIVITAI_KEY%"
    if errorlevel 1 (
        echo Failed to read CIVITAI_KEY.
        exit /b 1
    )
)

if not defined CIVITAI_KEY (
    echo CIVITAI_KEY is not defined.
    exit /b 1
)

set "DOWNLOAD_DIR=%~1"
set "DOWNLOAD_FILE=%~2"
set "MODEL_ID=%~3"
set "VERSION_ID=%~4"
if not defined VERSION_ID set "VERSION_ID=%MODEL_ID%"
set "DOWNLOAD_URL=https://civitai.red/api/download/models/%VERSION_ID%?token=%CIVITAI_KEY%"
set "MODEL_URL=https://civitai.red/models/%MODEL_ID%?modelVersionId=%VERSION_ID%"

echo %MODEL_URL%

call "%ARIA_BAT%" "%DOWNLOAD_DIR%" "%DOWNLOAD_FILE%" "%DOWNLOAD_URL%"
exit /b %ERRORLEVEL%
