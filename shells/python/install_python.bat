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

if not defined PYTHON_ZIP_RENAME (
    echo PYTHON_ZIP_RENAME is not defined.
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

set "SCRIPT_DIR=%~dp0"
set "PYTHON_DIR=%SCRIPT_DIR%%PYTHON_PATH%"
set "PYTHON_SCRIPTS_DIR=%PYTHON_DIR%\Scripts"
set "PYTHON_ZIP=%PYTHON_DIR%\%PYTHON_ZIP_RENAME%"
set "PYTHON_EXE=%PYTHON_DIR%\python.exe"
set "PYTHON_PTH=%PYTHON_DIR%\%PYTHON_PATH%._pth"
set "GET_PIP=%PYTHON_DIR%\get-pip.py"

if not exist "%PYTHON_DIR%" (
    mkdir "%PYTHON_DIR%"
    if errorlevel 1 (
        echo Failed to create Python directory: "%PYTHON_DIR%"
        exit /b 1
    )
)

curl -L --fail --ssl-no-revoke --output "%PYTHON_ZIP%" "%PYTHON_INSTALL_URL%"
if errorlevel 1 (
    echo Failed to download Python: "%PYTHON_INSTALL_URL%"
    exit /b 1
)

tar -xf "%PYTHON_ZIP%" -C "%PYTHON_DIR%"
if errorlevel 1 (
    echo Failed to extract Python archive: "%PYTHON_ZIP%"
    exit /b 1
)

if not exist "%PYTHON_PTH%" (
    echo Python path file does not exist: "%PYTHON_PTH%"
    exit /b 1
)

if not exist "%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" (
    echo powershell.exe is required to update Python path file: "%PYTHON_PTH%"
    exit /b 1
)

"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -Command "$path = $env:PYTHON_PTH; $text = [System.IO.File]::ReadAllText($path); $text = $text.Replace('#import site', 'import site'); [System.IO.File]::WriteAllText($path, $text, [System.Text.UTF8Encoding]::new($false))"
if errorlevel 1 (
    echo Failed to update Python path file: "%PYTHON_PTH%"
    exit /b 1
)

call set "PATH=%PYTHON_DIR%;%PYTHON_SCRIPTS_DIR%;%%PATH%%"

curl -sSL --fail --ssl-no-revoke "https://bootstrap.pypa.io/get-pip.py" -o "%GET_PIP%"
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

exit /b 0
