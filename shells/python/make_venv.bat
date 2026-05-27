@echo off

for %%I in ("%~dp0.") do set "SCRIPT_DIR=%%~fI"
set "SET_PYTHON_PATH=%SCRIPT_DIR%\set_python_path.bat"

if not exist "%SET_PYTHON_PATH%" (
    echo set_python_path.bat does not exist: "%SET_PYTHON_PATH%"
    exit /b 1
)

call "%SET_PYTHON_PATH%"
if errorlevel 1 (
    echo Failed to set Python path.
    exit /b 1
)

if "%~1"=="" (
    echo VENV_ROOT_DIR is required.
    exit /b 1
)

for %%I in ("%~1") do set "VENV_ROOT_DIR=%%~fI"
set "VENV_DIR=%VENV_ROOT_DIR%\venv"

if exist "%VENV_DIR%" (
    exit /b 0
)

if not exist "%VENV_ROOT_DIR%" (
    echo Venv root directory does not exist: "%VENV_ROOT_DIR%"
    exit /b 1
)

pushd "%VENV_ROOT_DIR%"
if errorlevel 1 (
    echo Failed to enter venv root directory: "%VENV_ROOT_DIR%"
    exit /b 1
)

uv venv venv --python 3.13 --seed
set "MAKE_VENV_RESULT=%ERRORLEVEL%"
popd

if not "%MAKE_VENV_RESULT%"=="0" (
    echo Failed to create virtual environment: "%VENV_DIR%"
    exit /b 1
)

exit /b 0
