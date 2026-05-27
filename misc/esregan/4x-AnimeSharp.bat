@echo off

for %%I in ("%~dp0..\..") do set "PROJECT_ROOT=%%~fI"
set "HUGGINGFACE_BAT=%PROJECT_ROOT%\shells\download\huggingface.bat"
set "DOWNLOAD_DIR=%PROJECT_ROOT%\models\ESRGAN"
set "DOWNLOAD_FILE=4x-AnimeSharp.pth"
set "REPO_ID=Zuntan/dist"
set "REPO_DIR="
set "DOWNLOAD_PATH=%DOWNLOAD_DIR%\%DOWNLOAD_FILE%"

if exist "%DOWNLOAD_PATH%" (
    exit /b 0
)

if not exist "%HUGGINGFACE_BAT%" (
    echo huggingface.bat does not exist: "%HUGGINGFACE_BAT%"
    exit /b 1
)

if not exist "%DOWNLOAD_DIR%" (
    mkdir "%DOWNLOAD_DIR%"
    if errorlevel 1 (
        echo Failed to create download directory: "%DOWNLOAD_DIR%"
        exit /b 1
    )
)

call "%HUGGINGFACE_BAT%" "%DOWNLOAD_DIR%" "%DOWNLOAD_FILE%" "%REPO_ID%" "%REPO_DIR%"
exit /b %ERRORLEVEL%
