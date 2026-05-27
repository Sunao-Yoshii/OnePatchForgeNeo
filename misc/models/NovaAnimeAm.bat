@echo off

for %%I in ("%~dp0..\..") do set "PROJECT_ROOT=%%~fI"
set "CIVITAI_BAT=%PROJECT_ROOT%\shells\download\civitai.bat"
set "DOWNLOAD_DIR=%PROJECT_ROOT%\models\Stable-diffusion"
set "DOWNLOAD_FILE=novaAnimeAM_v15.safetensors"
set "MODEL_ID=2957298"
set "VERSION_ID=2836641"
set "DOWNLOAD_PATH=%DOWNLOAD_DIR%\%DOWNLOAD_FILE%"

if exist "%DOWNLOAD_PATH%" (
    exit /b 0
)

if not exist "%CIVITAI_BAT%" (
    echo civitai.bat does not exist: "%CIVITAI_BAT%"
    exit /b 1
)

if not exist "%DOWNLOAD_DIR%" (
    mkdir "%DOWNLOAD_DIR%"
    if errorlevel 1 (
        echo Failed to create download directory: "%DOWNLOAD_DIR%"
        exit /b 1
    )
)

call "%CIVITAI_BAT%" "%DOWNLOAD_DIR%" "%DOWNLOAD_FILE%" "%MODEL_ID%" "%VERSION_ID%"
exit /b %ERRORLEVEL%
