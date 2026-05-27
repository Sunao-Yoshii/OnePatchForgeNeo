@echo off

for %%I in ("%~dp0.") do set "ADETAILER_DIR=%%~fI"
set "NIPPLES_YOLO=%ADETAILER_DIR%\bbox\nipples_yolov8s.bat"
set "PENIS_YOLO=%ADETAILER_DIR%\bbox\penisV2.bat"
set "PUSSY_YOLO=%ADETAILER_DIR%\bbox\pussyV2.bat"

if not exist "%NIPPLES_YOLO%" (
    echo nipples_yolov8s.bat does not exist: "%NIPPLES_YOLO%"
    exit /b 1
)

if not exist "%PENIS_YOLO%" (
    echo penisV2.bat does not exist: "%PENIS_YOLO%"
    exit /b 1
)

if not exist "%PUSSY_YOLO%" (
    echo pussyV2.bat does not exist: "%PUSSY_YOLO%"
    exit /b 1
)

call "%NIPPLES_YOLO%"
if errorlevel 1 (
    echo Failed to download nipples_yolov8s.
    exit /b 1
)

call "%PENIS_YOLO%"
if errorlevel 1 (
    echo Failed to download penisV2.
    exit /b 1
)

call "%PUSSY_YOLO%"
if errorlevel 1 (
    echo Failed to download pussyV2.
    exit /b 1
)

exit /b 0
