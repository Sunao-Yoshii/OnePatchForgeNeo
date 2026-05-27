@echo off

for %%I in ("%~dp0..\..") do set "PROJECT_ROOT=%%~fI"
set "CONFIG_JSON=%PROJECT_ROOT%\sd-webui-forge-neo\config.json"

if not exist "%CONFIG_JSON%" (
    echo config.json does not exist: "%CONFIG_JSON%"
    exit /b 1
)

if not exist "%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" (
    echo powershell.exe is required to read config.json.
    exit /b 1
)

for /f "usebackq delims=" %%K in (`%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "$config = Get-Content -Raw -LiteralPath $env:CONFIG_JSON | ConvertFrom-Json; $value = $config.ch_civiai_api_key; if ($null -ne $value) { [Console]::Write($value) }"`) do set "CIVITAI_KEY=%%K"

if not defined CIVITAI_KEY (
    echo ch_civiai_api_key is not defined in config.json.
    exit /b 1
)

exit /b 0
