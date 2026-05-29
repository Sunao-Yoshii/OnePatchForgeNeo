@echo off

if not defined PYTHON_VERSION (
    echo PYTHON_VERSION is not defined.
    exit /b 1
)

if not defined PYTHON_INSTALL_URL (
    echo PYTHON_INSTALL_URL is not defined.
    exit /b 1
)

if not defined PYTHON_PATH (
    echo PYTHON_PATH is not defined.
    exit /b 1
)

if not defined PYTHON_PACKAGE_FILE (
    echo PYTHON_PACKAGE_FILE is not defined.
    exit /b 1
)

if not defined PYTHON_ENV_PATH (
    echo PYTHON_ENV_PATH is not defined.
    exit /b 1
)

if not defined PYTHON_PACKAGE_TOOLS_PATH (
    echo PYTHON_PACKAGE_TOOLS_PATH is not defined.
    exit /b 1
)

if not defined PYTHON_GET_PIP_URL (
    echo PYTHON_GET_PIP_URL is not defined.
    exit /b 1
)

where python >nul 2>&1
if errorlevel 1 goto INSTALL_PYTHON

for /f "tokens=2" %%V in ('python --version 2^>^&1') do set "CURRENT_PYTHON_VERSION=%%V"
call set "CURRENT_PYTHON_PREFIX=%%CURRENT_PYTHON_VERSION:~0,4%%"
if "%CURRENT_PYTHON_PREFIX%"=="%PYTHON_VERSION%" (
    exit /b 0
)

:INSTALL_PYTHON

for %%I in ("%~dp0.") do set "SCRIPT_DIR=%%~fI"
set "PYTHON_ENV_DIR=%SCRIPT_DIR%\%PYTHON_ENV_PATH%"
set "PYTHON_DIR=%SCRIPT_DIR%\%PYTHON_PATH%"
set "PYTHON_SCRIPTS_DIR=%PYTHON_DIR%\Scripts"
set "PYTHON_PACKAGE=%PYTHON_ENV_DIR%\%PYTHON_PACKAGE_FILE%"
set "PYTHON_TOOLS_DIR=%PYTHON_ENV_DIR%\%PYTHON_PACKAGE_TOOLS_PATH%"
set "PYTHON_EXE=%PYTHON_DIR%\python.exe"
set "GET_PIP=%PYTHON_DIR%\get-pip.py"

if not exist "%PYTHON_ENV_DIR%" (
    mkdir "%PYTHON_ENV_DIR%"
    if errorlevel 1 (
        echo Failed to create Python env directory: "%PYTHON_ENV_DIR%"
        exit /b 1
    )
)

if not exist "%PYTHON_DIR%" (
    mkdir "%PYTHON_DIR%"
    if errorlevel 1 (
        echo Failed to create Python directory: "%PYTHON_DIR%"
        exit /b 1
    )
)

curl -L --fail --ssl-no-revoke --output "%PYTHON_PACKAGE%" "%PYTHON_INSTALL_URL%"
if errorlevel 1 (
    echo Failed to download Python: "%PYTHON_INSTALL_URL%"
    exit /b 1
)

tar -xf "%PYTHON_PACKAGE%" -C "%PYTHON_ENV_DIR%"
if errorlevel 1 (
    echo Failed to extract Python package: "%PYTHON_PACKAGE%"
    exit /b 1
)

if not exist "%PYTHON_TOOLS_DIR%" (
    echo Python tools directory does not exist: "%PYTHON_TOOLS_DIR%"
    exit /b 1
)

robocopy "%PYTHON_TOOLS_DIR%" "%PYTHON_DIR%" /E /MOVE >nul
if errorlevel 8 (
    echo Failed to move Python tools into: "%PYTHON_DIR%"
    exit /b 1
)

del /f /q "%PYTHON_DIR%\*._pth" >nul 2>&1

call set "PATH=%PYTHON_DIR%;%PYTHON_SCRIPTS_DIR%;%%PATH%%"

curl -sSL --fail --ssl-no-revoke "%PYTHON_GET_PIP_URL%" -o "%GET_PIP%"
if errorlevel 1 (
    echo Failed to download get-pip.py.
    exit /b 1
)

pushd "%PYTHON_DIR%"
if errorlevel 1 (
    echo Failed to enter Python directory: "%PYTHON_DIR%"
    exit /b 1
)

"%PYTHON_EXE%" get-pip.py
set "PIP_INSTALL_RESULT=%ERRORLEVEL%"
popd

if not "%PIP_INSTALL_RESULT%"=="0" (
    echo Failed to install pip.
    exit /b 1
)

pip install uv
if errorlevel 1 (
    echo Failed to install uv.
    exit /b 1
)

exit /b 0
