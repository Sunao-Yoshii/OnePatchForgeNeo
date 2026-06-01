@echo off

for %%I in ("%~dp0.") do set "SCRIPT_DIR=%%~fI"
for %%I in ("%~dp0..\..") do set "PROJECT_ROOT=%%~fI"
set "INSTALL_EXTENSION=%SCRIPT_DIR%\install_extension.bat"
set "SET_SYMBOLIC_LINK=%SCRIPT_DIR%\set_symbolic_link.bat"
set "OLD_TAGCOMPLETE_DIR=%PROJECT_ROOT%\sd-webui-forge-neo\extensions\a1111-sd-webui-tagcomplete"

if not exist "%INSTALL_EXTENSION%" (
    echo install_extension.bat does not exist: "%INSTALL_EXTENSION%"
    exit /b 1
)

if not exist "%SET_SYMBOLIC_LINK%" (
    echo set_symbolic_link.bat does not exist: "%SET_SYMBOLIC_LINK%"
    exit /b 1
)

if exist "%OLD_TAGCOMPLETE_DIR%" (
    rmdir /s /q "%OLD_TAGCOMPLETE_DIR%"
    if exist "%OLD_TAGCOMPLETE_DIR%" (
        echo Failed to remove extension: "%OLD_TAGCOMPLETE_DIR%"
        exit /b 1
    )
)

call "%INSTALL_EXTENSION%" "https://github.com/eduardoabreu81/sd-webui-tagcomplete-neo.git" "main" "sd-webui-tagcomplete-neo"
if errorlevel 1 exit /b 1

call "%INSTALL_EXTENSION%" "https://github.com/abzaloff/aadetailer-neoforge.git" "main" "aadetailer-neoforge"
if errorlevel 1 exit /b 1

call "%INSTALL_EXTENSION%" "https://github.com/abzaloff/sd-dynamic-prompts" "main" "sd-dynamic-prompts"
if errorlevel 1 exit /b 1

call "%INSTALL_EXTENSION%" "https://github.com/meki/sdweb-easy-prompt-selector.git" "main" "sdweb-easy-prompt-selector"
if errorlevel 1 exit /b 1

call "%INSTALL_EXTENSION%" "https://github.com/altoiddealer/--sd-webui-ar-plusplus.git" "main" "--sd-webui-ar-plusplus"
if errorlevel 1 exit /b 1

call "%INSTALL_EXTENSION%" "https://github.com/hirorohi03/repeat-generate-4NEO.git" "main" "repeat-generate-4NEO"
if errorlevel 1 exit /b 1

call "%INSTALL_EXTENSION%" "https://github.com/Haoming02/sd-forge-negpip.git" "classic" "sd-forge-negpip"
if errorlevel 1 exit /b 1

call "%INSTALL_EXTENSION%" "https://github.com/KohakuBlueleaf/z-tipo-extension.git" "main" "z-tipo-extension"
if errorlevel 1 exit /b 1

call "%INSTALL_EXTENSION%" "https://github.com/SiliconeShojo/ScribeNEO.git" "main" "ScribeNEO"
if errorlevel 1 exit /b 1

call "%INSTALL_EXTENSION%" "https://github.com/bluelovers/sd-webui-pnginfo-beautify.git" "master" "sd-webui-pnginfo-beautify"
if errorlevel 1 exit /b 1

call "%INSTALL_EXTENSION%" "https://github.com/eduardoabreu81/sd-webui-prompt-all-in-one-neo.git" "main" "sd-webui-prompt-all-in-one-neo"
if errorlevel 1 exit /b 1

set "PROMPT_ALL_IN_ONE_TEMPLATE_DIR=%SCRIPT_DIR%\extensions\sd-webui-prompt-all-in-one-neo"
set "PROMPT_ALL_IN_ONE_STORAGE_DIR=%PROJECT_ROOT%\sd-webui-forge-neo\extensions\sd-webui-prompt-all-in-one-neo\storage"

if not exist "%PROMPT_ALL_IN_ONE_STORAGE_DIR%" (
    mkdir "%PROMPT_ALL_IN_ONE_STORAGE_DIR%"
    if errorlevel 1 exit /b 1
)

if exist "%PROMPT_ALL_IN_ONE_TEMPLATE_DIR%\*.json" (
    copy /Y "%PROMPT_ALL_IN_ONE_TEMPLATE_DIR%\*.json" "%PROMPT_ALL_IN_ONE_STORAGE_DIR%\" >nul
    if errorlevel 1 exit /b 1
)

call "%INSTALL_EXTENSION%" "https://github.com/Chiralistic/Stable-diffusion-webui-civitai-helper-RED-UPDATE.git" "master" "Stable-diffusion-webui-civitai-helper-RED-UPDATE"
if errorlevel 1 exit /b 1

call "%INSTALL_EXTENSION%" "https://github.com/AI-Creators-Society/stable-diffusion-webui-localization-ja_JP" "main" "stable-diffusion-webui-localization-ja_JP"
if errorlevel 1 exit /b 1

call "%INSTALL_EXTENSION%" "https://github.com/AUTOMATIC1111/stable-diffusion-webui-wildcards.git" "master" "stable-diffusion-webui-wildcards"
if errorlevel 1 exit /b 1

call "%SET_SYMBOLIC_LINK%" "%PROJECT_ROOT%\sd-webui-forge-neo\models\Stable-diffusion" "%PROJECT_ROOT%\models\Stable-diffusion"
if errorlevel 1 exit /b 1

call "%SET_SYMBOLIC_LINK%" "%PROJECT_ROOT%\sd-webui-forge-neo\models\adetailer" "%PROJECT_ROOT%\models\adetailer"
if errorlevel 1 exit /b 1

call "%SET_SYMBOLIC_LINK%" "%PROJECT_ROOT%\sd-webui-forge-neo\extensions\sd-dynamic-prompts\wildcards" "%PROJECT_ROOT%\models\wildcards"
if errorlevel 1 exit /b 1

if not exist "%PROJECT_ROOT%\sd-webui-forge-neo\extensions\sdweb-easy-prompt-selector\tags" (
    mkdir "%PROJECT_ROOT%\sd-webui-forge-neo\extensions\sdweb-easy-prompt-selector\tags"
    if errorlevel 1 exit /b 1
)

if exist "%PROJECT_ROOT%\models\easy_prompts" (
    robocopy "%PROJECT_ROOT%\models\easy_prompts" "%PROJECT_ROOT%\sd-webui-forge-neo\extensions\sdweb-easy-prompt-selector\tags" /E >nul
    if errorlevel 8 exit /b 1
)

call "%SET_SYMBOLIC_LINK%" "%PROJECT_ROOT%\models\easy_prompt_selector" "%PROJECT_ROOT%\sd-webui-forge-neo\extensions\sdweb-easy-prompt-selector\tags"
if errorlevel 1 exit /b 1

call "%SET_SYMBOLIC_LINK%" "%PROJECT_ROOT%\sd-webui-forge-neo\extensions\stable-diffusion-webui-wildcards\wildcards" "%PROJECT_ROOT%\models\wildcards"
if errorlevel 1 exit /b 1

exit /b 0
