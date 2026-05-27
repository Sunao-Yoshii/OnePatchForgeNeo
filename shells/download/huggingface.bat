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
    echo REPO_ID is required.
    exit /b 1
)

for %%I in ("%~dp0.") do set "SCRIPT_DIR=%%~fI"
set "ARIA_BAT=%SCRIPT_DIR%\aria.bat"

if not exist "%ARIA_BAT%" (
    echo aria.bat does not exist: "%ARIA_BAT%"
    exit /b 1
)

set "DOWNLOAD_DIR=%~1"
set "DOWNLOAD_FILE=%~2"
set "REPO_ID=%~3"
set "REPO_DIR=%~4"

if "%REPO_DIR%"=="" goto HF_REPO_PATH_ROOT
if "%REPO_DIR:~-1%"=="/" goto HF_REPO_PATH_DIR
set "HF_REPO_PATH=%REPO_DIR%"
goto HF_DOWNLOAD

:HF_REPO_PATH_ROOT
set "HF_REPO_PATH=%DOWNLOAD_FILE%"
goto HF_DOWNLOAD

:HF_REPO_PATH_DIR
set "HF_REPO_PATH=%REPO_DIR%%DOWNLOAD_FILE%"

:HF_DOWNLOAD
set "HF_DOWNLOAD_URL=https://huggingface.co/%REPO_ID%/resolve/main/%HF_REPO_PATH%"

call "%ARIA_BAT%" "%DOWNLOAD_DIR%" "%DOWNLOAD_FILE%" "%HF_DOWNLOAD_URL%"
exit /b %ERRORLEVEL%
