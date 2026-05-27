@echo off

for %%I in ("%~dp0.") do set "MISC_DIR=%%~fI"
set "CIVITAI_DETAILERS=%MISC_DIR%\adetailer\civitai_detailers.bat"

if not exist "%CIVITAI_DETAILERS%" (
    echo civitai_detailers.bat does not exist: "%CIVITAI_DETAILERS%"
    exit /b 1
)

call "%CIVITAI_DETAILERS%"
exit /b %ERRORLEVEL%
