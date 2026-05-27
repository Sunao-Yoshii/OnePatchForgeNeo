@echo off
setlocal EnableExtensions
if exist "%SystemRoot%\System32\chcp.com" "%SystemRoot%\System32\chcp.com" 65001 >nul

set "PORTABLE_GIT_VERSION=2.54.0"
set "PROJECT_REPOSITORY_URL=https://github.com/Sunao-Yoshii/OnePatchForgeNeo.git"
set "PROJECT_BRANCH=main"

set "SCRIPT_DIR=%~dp0"
set "INSTALL_DIR=%CD%"
for %%I in ("%INSTALL_DIR%") do set "INSTALL_DIR=%%~fI"
set "ENV_DIR=%SCRIPT_DIR%shells\git\env"
set "PORTABLE_GIT_DIR=%SCRIPT_DIR%shells\git\env\PortableGit"
set "PORTABLE_GIT_BIN_DIR=%SCRIPT_DIR%shells\git\env\PortableGit\bin"
set "PORTABLE_GIT_INSTALLER=%SCRIPT_DIR%shells\git\env\PortableGit.7z.exe"
set "PORTABLE_GIT_URL=https://github.com/git-for-windows/git/releases/download/v%PORTABLE_GIT_VERSION%.windows.1/PortableGit-%PORTABLE_GIT_VERSION%-64-bit.7z.exe"

where git >nul 2>&1
if errorlevel 1 (
    if not exist "%ENV_DIR%" (
        mkdir "%ENV_DIR%"
        if errorlevel 1 (
            echo Failed to create env directory: "%ENV_DIR%"
            exit /b 1
        )
    )

    curl -L --fail --ssl-no-revoke --output "%PORTABLE_GIT_INSTALLER%" "%PORTABLE_GIT_URL%"
    if errorlevel 1 (
        echo Failed to download Portable Git for Windows.
        exit /b 1
    )

    echo 操作せずに、そのまま Portable Git for Windows をインストールしてください。
    start /wait "" "%PORTABLE_GIT_INSTALLER%" -o"%PORTABLE_GIT_DIR%" -y
    if errorlevel 1 (
        echo Portable Git for Windows installer failed.
        exit /b 1
    )

    call set "PATH=%PORTABLE_GIT_BIN_DIR%;%%PATH%%"
)

git --version >nul 2>&1
if errorlevel 1 (
    echo git command is not available.
    exit /b 1
)

if exist "%INSTALL_DIR%\.git" (
    git -C "%INSTALL_DIR%" fetch origin "%PROJECT_BRANCH%"
    if errorlevel 1 (
        echo Failed to fetch project repository: "%PROJECT_REPOSITORY_URL%"
        exit /b 1
    )

    git -C "%INSTALL_DIR%" checkout "%PROJECT_BRANCH%"
    if errorlevel 1 (
        echo Failed to checkout branch: "%PROJECT_BRANCH%"
        exit /b 1
    )

    git -C "%INSTALL_DIR%" pull --ff-only origin "%PROJECT_BRANCH%"
    if errorlevel 1 (
        echo Failed to update project repository.
        exit /b 1
    )

    exit /b 0
)

dir /a /b "%INSTALL_DIR%" >nul 2>&1
if not errorlevel 1 (
    git -C "%INSTALL_DIR%" init
    if errorlevel 1 (
        echo Failed to initialize project repository in: "%INSTALL_DIR%"
        exit /b 1
    )

    git -C "%INSTALL_DIR%" remote add origin "%PROJECT_REPOSITORY_URL%" >nul 2>&1
    if errorlevel 1 (
        git -C "%INSTALL_DIR%" remote set-url origin "%PROJECT_REPOSITORY_URL%"
        if errorlevel 1 (
            echo Failed to configure project repository remote: "%PROJECT_REPOSITORY_URL%"
            exit /b 1
        )
    )

    git -C "%INSTALL_DIR%" fetch origin "%PROJECT_BRANCH%"
    if errorlevel 1 (
        echo Failed to fetch project repository: "%PROJECT_REPOSITORY_URL%"
        exit /b 1
    )

    git -C "%INSTALL_DIR%" checkout -f "%PROJECT_BRANCH%"
    if errorlevel 1 (
        git -C "%INSTALL_DIR%" checkout -f -B "%PROJECT_BRANCH%" "origin/%PROJECT_BRANCH%"
        if errorlevel 1 (
            echo Failed to checkout branch: "%PROJECT_BRANCH%"
            exit /b 1
        )
    )

    exit /b 0
)

git clone --branch "%PROJECT_BRANCH%" "%PROJECT_REPOSITORY_URL%" "%INSTALL_DIR%"
if errorlevel 1 (
    echo Failed to clone project repository into: "%INSTALL_DIR%"
    exit /b 1
)

exit /b 0
