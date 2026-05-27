@echo off
set "PROJECT_ROOT=%~dp0"
set "VERSION_CONTROL=%PROJECT_ROOT%shells\version_control.bat"
set "SET_GIT_PATH=%PROJECT_ROOT%shells\git\set_git_path.bat"
set "SET_PYTHON_PATH=%PROJECT_ROOT%shells\python\set_python_path.bat"
set "FORGE_DIR=%PROJECT_ROOT%sd-webui-forge-neo"
set "MODEL_REF_DIR=%PROJECT_ROOT%models"
set "FORGE_VENV_ACTIVATE=%FORGE_DIR%\venv\Scripts\activate.bat"
set "FORGE_WEBUI=%FORGE_DIR%\webui.bat"

if not exist "%VERSION_CONTROL%" (
    echo version_control.bat does not exist: "%VERSION_CONTROL%"
    exit /b 1
)

if not exist "%SET_GIT_PATH%" (
    echo set_git_path.bat does not exist: "%SET_GIT_PATH%"
    exit /b 1
)

if not exist "%SET_PYTHON_PATH%" (
    echo set_python_path.bat does not exist: "%SET_PYTHON_PATH%"
    exit /b 1
)

if not exist "%FORGE_VENV_ACTIVATE%" (
    echo Forge Neo venv activate.bat does not exist: "%FORGE_VENV_ACTIVATE%"
    exit /b 1
)

if not exist "%FORGE_WEBUI%" (
    echo Forge Neo webui.bat does not exist: "%FORGE_WEBUI%"
    exit /b 1
)

call "%VERSION_CONTROL%"
if errorlevel 1 (
    echo Failed to load version control settings.
    exit /b 1
)

call "%SET_GIT_PATH%"
if errorlevel 1 (
    echo Failed to set git path.
    exit /b 1
)

call "%SET_PYTHON_PATH%"
if errorlevel 1 (
    echo Failed to set Python path.
    exit /b 1
)

pushd "%FORGE_DIR%"
if errorlevel 1 (
    echo Failed to enter Forge Neo directory: "%FORGE_DIR%"
    exit /b 1
)

call "%FORGE_VENV_ACTIVATE%"
if errorlevel 1 (
    echo Failed to activate Forge Neo virtual environment.
    popd
    exit /b 1
)

set COMMANDLINE_ARGS=--uv --sage --cuda-malloc --model-ref "%MODEL_REF_DIR%"
call "%FORGE_WEBUI%"
set "FORGE_WEBUI_RESULT=%ERRORLEVEL%"
popd
exit /b %FORGE_WEBUI_RESULT%
