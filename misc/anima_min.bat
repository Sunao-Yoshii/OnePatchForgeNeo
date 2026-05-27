@echo off

for %%I in ("%~dp0.") do set "MISC_DIR=%%~fI"
set "ANIMA_MODEL=%MISC_DIR%\models\anima1.0.bat"
set "QWEN_VAE=%MISC_DIR%\vae\qwen_image_vae.bat"
set "QWEN_TEXT_ENCODER=%MISC_DIR%\text_encoders\qwen_3_06b_base.bat"
set "ANIME_SHARP=%MISC_DIR%\esregan\4x-AnimeSharp.bat"
set "ADETAILER=%MISC_DIR%\adetailer\hugging_face_detailers.bat"

if not exist "%ANIMA_MODEL%" (
    echo anima1.0.bat does not exist: "%ANIMA_MODEL%"
    exit /b 1
)

if not exist "%QWEN_VAE%" (
    echo qwen_image_vae.bat does not exist: "%QWEN_VAE%"
    exit /b 1
)

if not exist "%QWEN_TEXT_ENCODER%" (
    echo qwen_3_06b_base.bat does not exist: "%QWEN_TEXT_ENCODER%"
    exit /b 1
)

if not exist "%ANIME_SHARP%" (
    echo 4x-AnimeSharp.bat does not exist: "%ANIME_SHARP%"
    exit /b 1
)

if not exist "%ADETAILER%" (
    echo hugging_face_detailers.bat does not exist: "%ADETAILER%"
    exit /b 1
)

call "%ANIMA_MODEL%"
if errorlevel 1 (
    echo Failed to download Anima model.
    exit /b 1
)

call "%QWEN_VAE%"
if errorlevel 1 (
    echo Failed to download Qwen image VAE.
    exit /b 1
)

call "%QWEN_TEXT_ENCODER%"
if errorlevel 1 (
    echo Failed to download Qwen text encoder.
    exit /b 1
)

call "%ANIME_SHARP%"
if errorlevel 1 (
    echo Failed to download 4x-AnimeSharp.
    exit /b 1
)

call "%ADETAILER%"
if errorlevel 1 (
    echo Failed to download ADetailer models.
    exit /b 1
)

exit /b 0
