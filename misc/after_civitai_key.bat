@echo off

for %%I in ("%~dp0.") do set "MISC_DIR=%%~fI"
set "CIVITAI_DETAILERS=%MISC_DIR%\adetailer\civitai_detailers.bat"
set "HASSAKU_ANIMA=%MISC_DIR%\models\hassakuAnima_v01.bat"
set "NOVA_ANIME_AM=%MISC_DIR%\models\NovaAnimeAm.bat"

if not exist "%CIVITAI_DETAILERS%" (
    echo civitai_detailers.bat does not exist: "%CIVITAI_DETAILERS%"
    exit /b 1
)

if not exist "%HASSAKU_ANIMA%" (
    echo hassakuAnima_v01.bat does not exist: "%HASSAKU_ANIMA%"
    exit /b 1
)

if not exist "%NOVA_ANIME_AM%" (
    echo NovaAnimeAm.bat does not exist: "%NOVA_ANIME_AM%"
    exit /b 1
)

call "%CIVITAI_DETAILERS%"
if errorlevel 1 (
    echo Failed to download Civitai detailer models.
    exit /b 1
)

call "%HASSAKU_ANIMA%"
if errorlevel 1 (
    echo Failed to download hassakuAnima_v01.
    exit /b 1
)

call "%NOVA_ANIME_AM%"
if errorlevel 1 (
    echo Failed to download NovaAnimeAm.
    exit /b 1
)

exit /b 0
