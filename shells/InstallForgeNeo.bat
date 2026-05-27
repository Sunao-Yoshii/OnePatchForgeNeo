@echo off
set "SCRIPT_DIR=%~dp0"
set "VERSION_CONTROL=%SCRIPT_DIR%version_control.bat"
set "INSTALL_PYTHON=%SCRIPT_DIR%python\install_python.bat"

if not exist "%VERSION_CONTROL%" (
    echo version_control.bat does not exist: "%VERSION_CONTROL%"
    exit /b 1
)

if not exist "%INSTALL_PYTHON%" (
    echo install_python.bat does not exist: "%INSTALL_PYTHON%"
    exit /b 1
)

call "%VERSION_CONTROL%"
if errorlevel 1 (
    echo Failed to load version control settings.
    exit /b 1
)

call "%INSTALL_PYTHON%"
if errorlevel 1 (
    echo Failed to install Python.
    exit /b 1
)

exit /b 0
