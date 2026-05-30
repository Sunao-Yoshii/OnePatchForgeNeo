@echo off

for %%I in ("%~dp0.") do set "SCRIPT_DIR=%%~fI"
set "ENV_DIR=%SCRIPT_DIR%\env"
set "VC_REDIST_URL=https://aka.ms/vc14/vc_redist.x64.exe"
set "VC_REDIST_EXE=%ENV_DIR%\vc_redist.x64.exe"
set "POWERSHELL_EXE=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe"

if not exist "%ENV_DIR%" (
    mkdir "%ENV_DIR%"
    if errorlevel 1 (
        echo Failed to create env directory: "%ENV_DIR%"
        exit /b 1
    )
)

curl -L --fail --ssl-no-revoke --output "%VC_REDIST_EXE%" "%VC_REDIST_URL%"
if errorlevel 1 (
    echo Failed to download Visual C++ Redistributable: "%VC_REDIST_URL%"
    exit /b 1
)

if not exist "%POWERSHELL_EXE%" (
    echo powershell.exe is required to compare Visual C++ Redistributable versions.
    exit /b 1
)

for /f "usebackq delims=" %%V in (`%POWERSHELL_EXE% -NoProfile -ExecutionPolicy Bypass -Command "$version = (Get-Item -LiteralPath $env:VC_REDIST_EXE).VersionInfo.ProductVersion; if ($version) { [Console]::Write($version.TrimStart('v')) }"`) do set "VC_REDIST_TARGET_VERSION=%%V"

for /f "usebackq delims=" %%V in (`%POWERSHELL_EXE% -NoProfile -ExecutionPolicy Bypass -Command "$runtime = Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\VisualStudio\14.0\VC\Runtimes\x64' -ErrorAction SilentlyContinue; if ($runtime -and $runtime.Installed -eq 1 -and $runtime.Version) { [Console]::Write($runtime.Version.TrimStart('v')) }"`) do set "VC_REDIST_INSTALLED_VERSION=%%V"

if not defined VC_REDIST_TARGET_VERSION (
    echo Failed to read Visual C++ Redistributable installer version: "%VC_REDIST_EXE%"
    exit /b 1
)

if defined VC_REDIST_INSTALLED_VERSION (
    "%POWERSHELL_EXE%" -NoProfile -ExecutionPolicy Bypass -Command "if ([version]$env:VC_REDIST_INSTALLED_VERSION -ge [version]$env:VC_REDIST_TARGET_VERSION) { exit 0 } else { exit 1 }"
    if not errorlevel 1 (
        exit /b 0
    )
)

start /wait "" "%VC_REDIST_EXE%" /install /quiet /norestart
if "%ERRORLEVEL%"=="3010" (
    exit /b 0
)
if errorlevel 1 (
    echo Failed to install Visual C++ Redistributable.
    exit /b 1
)

exit /b 0
