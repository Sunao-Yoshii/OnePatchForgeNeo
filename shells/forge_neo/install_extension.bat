@echo off

if "%~1"=="" (
    echo REPO_URL is required.
    exit /b 1
)

if "%~2"=="" (
    echo BRANCH is required.
    exit /b 1
)

if "%~3"=="" (
    echo DIR_NAME is required.
    exit /b 1
)

for %%I in ("%~dp0..\..") do set "PROJECT_ROOT=%%~fI"
set "SET_GIT_PATH=%PROJECT_ROOT%\shells\git\set_git_path.bat"
set "EXTENSIONS_DIR=%PROJECT_ROOT%\sd-webui-forge-neo\extensions"
set "REPO_URL=%~1"
set "BRANCH=%~2"
set "DIR_NAME=%~3"
set "EXTENSION_DIR=%EXTENSIONS_DIR%\%DIR_NAME%"

if exist "%EXTENSION_DIR%" (
    exit /b 0
)

if not exist "%SET_GIT_PATH%" (
    echo set_git_path.bat does not exist: "%SET_GIT_PATH%"
    exit /b 1
)

if not exist "%EXTENSIONS_DIR%" (
    mkdir "%EXTENSIONS_DIR%"
    if errorlevel 1 (
        echo Failed to create extensions directory: "%EXTENSIONS_DIR%"
        exit /b 1
    )
)

call "%SET_GIT_PATH%"
if errorlevel 1 (
    echo Failed to set git path.
    exit /b 1
)

git clone --branch "%BRANCH%" "%REPO_URL%" "%EXTENSION_DIR%"
if errorlevel 1 (
    echo Failed to clone extension repository: "%REPO_URL%"
    exit /b 1
)

exit /b 0
