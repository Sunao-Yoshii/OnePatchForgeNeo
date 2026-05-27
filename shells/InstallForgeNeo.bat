@echo off
if exist "%SystemRoot%\System32\chcp.com" "%SystemRoot%\System32\chcp.com" 65001 >nul

set /p "USER_CONFIRM=動作に必要なモデルなどをダウンロードします。よろしいですか？ [y/n]（空欄なら y） "
if not defined USER_CONFIRM set "USER_CONFIRM=y"
if /i "%USER_CONFIRM%"=="n" exit /b 0

set "SCRIPT_DIR=%~dp0"
set "PROJECT_ROOT=%SCRIPT_DIR%.."
for %%I in ("%PROJECT_ROOT%") do set "PROJECT_ROOT=%%~fI"
set "VERSION_CONTROL=%SCRIPT_DIR%version_control.bat"
set "INSTALL_PYTHON=%SCRIPT_DIR%python\install_python.bat"
set "MAKE_VENV=%SCRIPT_DIR%python\make_venv.bat"
set "SET_GIT_PATH=%SCRIPT_DIR%git\set_git_path.bat"
set "DOWNLOAD_ARIA=%SCRIPT_DIR%download\download_aria.bat"
set "FORGE_REPOSITORY_URL=https://github.com/Haoming02/sd-webui-forge-classic.git"
set "FORGE_BRANCH=neo"
set "FORGE_DIR=%PROJECT_ROOT%\sd-webui-forge-neo"
set "ANIMA_MIN=%PROJECT_ROOT%\misc\anima_min.bat"
set "SET_SYMBOLIC_LINKS=%SCRIPT_DIR%forge_neo\set_symbolic_links.bat"
set "INSTALL_EXTENSIONS=%SCRIPT_DIR%forge_neo\install_extensions.bat"

echo "call : %VERSION_CONTROL%"

if not exist "%VERSION_CONTROL%" (
    echo version_control.bat does not exist: "%VERSION_CONTROL%"
    exit /b 1
)

if not exist "%INSTALL_PYTHON%" (
    echo install_python.bat does not exist: "%INSTALL_PYTHON%"
    exit /b 1
)

if not exist "%MAKE_VENV%" (
    echo make_venv.bat does not exist: "%MAKE_VENV%"
    exit /b 1
)

if not exist "%SET_GIT_PATH%" (
    echo set_git_path.bat does not exist: "%SET_GIT_PATH%"
    exit /b 1
)

if not exist "%DOWNLOAD_ARIA%" (
    echo download_aria.bat does not exist: "%DOWNLOAD_ARIA%"
    exit /b 1
)

if not exist "%ANIMA_MIN%" (
    echo anima_min.bat does not exist: "%ANIMA_MIN%"
    exit /b 1
)

if not exist "%SET_SYMBOLIC_LINKS%" (
    echo set_symbolic_links.bat does not exist: "%SET_SYMBOLIC_LINKS%"
    exit /b 1
)

if not exist "%INSTALL_EXTENSIONS%" (
    echo install_extensions.bat does not exist: "%INSTALL_EXTENSIONS%"
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

call "%SET_GIT_PATH%"
if errorlevel 1 (
    echo Failed to set git path.
    exit /b 1
)

where git >nul 2>&1
if errorlevel 1 (
    echo git command is not available.
    exit /b 1
)

if exist "%FORGE_DIR%\.git" (
    git -C "%FORGE_DIR%" fetch origin "%FORGE_BRANCH%"
    if errorlevel 1 (
        echo Failed to fetch Forge Neo repository.
        exit /b 1
    )

    git -C "%FORGE_DIR%" checkout "%FORGE_BRANCH%"
    if errorlevel 1 (
        echo Failed to checkout Forge Neo branch: "%FORGE_BRANCH%"
        exit /b 1
    )

    git -C "%FORGE_DIR%" pull --ff-only origin "%FORGE_BRANCH%"
    if errorlevel 1 (
        echo Failed to update Forge Neo repository.
        exit /b 1
    )
) else (
    if exist "%FORGE_DIR%" (
        echo Forge Neo directory already exists and is not a git repository: "%FORGE_DIR%"
        exit /b 1
    )

    git clone --branch "%FORGE_BRANCH%" "%FORGE_REPOSITORY_URL%" "%FORGE_DIR%"
    if errorlevel 1 (
        echo Failed to clone Forge Neo repository.
        exit /b 1
    )
)

call "%DOWNLOAD_ARIA%"
if errorlevel 1 (
    echo Failed to download aria2.
    exit /b 1
)

pip install uv
if errorlevel 1 (
    echo Failed to install uv.
    exit /b 1
)

call "%MAKE_VENV%" "%FORGE_DIR%"
if errorlevel 1 (
    echo Failed to create Forge Neo virtual environment.
    exit /b 1
)

call "%ANIMA_MIN%"
if errorlevel 1 (
    echo Failed to download Anima minimum model set.
    exit /b 1
)

call "%SET_SYMBOLIC_LINKS%"
if errorlevel 1 (
    echo Failed to set Forge Neo symbolic links.
    exit /b 1
)

call "%INSTALL_EXTENSIONS%"
if errorlevel 1 (
    echo Failed to install Forge Neo extensions.
    exit /b 1
)

exit /b 0
