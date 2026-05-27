@echo off

for %%I in ("%~dp0..\..") do set "PROJECT_ROOT=%%~fI"
for %%I in ("%~dp0.") do set "SCRIPT_DIR=%%~fI"
set "SET_SYMBOLIC_LINK=%SCRIPT_DIR%\set_symbolic_link.bat"
set "LINK_DIR=%PROJECT_ROOT%\output"
set "TARGET_DIR=%PROJECT_ROOT%\sd-webui-forge-neo\output"

if not exist "%SET_SYMBOLIC_LINK%" (
    echo set_symbolic_link.bat does not exist: "%SET_SYMBOLIC_LINK%"
    exit /b 1
)

call "%SET_SYMBOLIC_LINK%" "%LINK_DIR%" "%TARGET_DIR%"
exit /b %ERRORLEVEL%
