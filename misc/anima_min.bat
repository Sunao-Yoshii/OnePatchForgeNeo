@echo off

for %%I in ("%~dp0.") do set "MISC_DIR=%%~fI"
set "ANIMA_MODEL=%MISC_DIR%\models\anima1.0.bat"
set "OOO_ANIMA=%MISC_DIR%\models\oooAnima_v10.bat"
set "QWEN_VAE=%MISC_DIR%\vae\qwen_image_vae.bat"
set "QWEN_TEXT_ENCODER=%MISC_DIR%\text_encoders\qwen_3_06b_base.bat"
set "ANIME_SHARP=%MISC_DIR%\esregan\4x-AnimeSharp.bat"
set "ADETAILER=%MISC_DIR%\adetailer\hugging_face_detailers.bat"
set "ANIMA_HIGHRES=%MISC_DIR%\lora\AnimaHighres.bat"
set "ANIMA_TURBO_LORA=%MISC_DIR%\lora\AnimaTurboLoRA.bat"

if not exist "%ANIMA_MODEL%" (
    echo anima1.0.bat does not exist: "%ANIMA_MODEL%"
    exit /b 1
)

if not exist "%OOO_ANIMA%" (
    echo oooAnima_v10.bat does not exist: "%OOO_ANIMA%"
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

if not exist "%ANIMA_HIGHRES%" (
    echo AnimaHighres.bat does not exist: "%ANIMA_HIGHRES%"
    exit /b 1
)

if not exist "%ANIMA_TURBO_LORA%" (
    echo AnimaTurboLoRA.bat does not exist: "%ANIMA_TURBO_LORA%"
    exit /b 1
)

call "%ANIMA_MODEL%"
if errorlevel 1 (
    echo Failed to download Anima model.
    exit /b 1
)

call "%OOO_ANIMA%"
if errorlevel 1 (
    echo Failed to download oooAnima_v10.
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
