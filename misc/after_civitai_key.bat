@echo off

for %%I in ("%~dp0.") do set "MISC_DIR=%%~fI"
set "CIVITAI_DETAILERS=%MISC_DIR%\adetailer\civitai_detailers.bat"
set "HASSAKU_ANIMA=%MISC_DIR%\models\hassakuAnima_v01.bat"
set "NOVA_ANIME_AM=%MISC_DIR%\models\NovaAnimeAm.bat"
set "OOO_ANIMA=%MISC_DIR%\models\oooAnima_v10.bat"
set "ANIMA_HIGHRES=%MISC_DIR%\lora\AnimaHighres.bat"
set "ANIMA_TURBO_LORA=%MISC_DIR%\lora\AnimaTurboLoRA.bat"

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

if not exist "%OOO_ANIMA%" (
    echo oooAnima_v10.bat does not exist: "%OOO_ANIMA%"
    exit /b 1
)

if not exist "%ANIMA_HIGHRES%" (
    echo AnimaHighres.bat does not exist: "%ANIMA_HIGHRES%"
    exit /b 1
)

if not exist "%ANIMA_TURBO_LORA%" (
    echo AnimaTurboLoRA.bat does not exist: "%ANIMA_TURBO_LORA%"
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

call "%OOO_ANIMA%"
if errorlevel 1 (
    echo Failed to download oooAnima_v10.
    exit /b 1
)

call "%ANIMA_HIGHRES%"
if errorlevel 1 (
    echo Failed to download AnimaHighres.
    exit /b 1
)

call "%ANIMA_TURBO_LORA%"
if errorlevel 1 (
    echo Failed to download AnimaTurboLoRA.
    exit /b 1
)

exit /b 0
