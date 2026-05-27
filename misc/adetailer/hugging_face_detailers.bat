@echo off

for %%I in ("%~dp0.") do set "ADETAILER_DIR=%%~fI"
set "FACE_YOLO=%ADETAILER_DIR%\bbox\face_yolov9c.bat"
set "HAND_YOLO=%ADETAILER_DIR%\bbox\hand_yolov9c.bat"
set "FACE_SEGM=%ADETAILER_DIR%\segm\AnzhcFace-v2-768MS-seg.bat"

if not exist "%FACE_YOLO%" (
    echo face_yolov9c.bat does not exist: "%FACE_YOLO%"
    exit /b 1
)

if not exist "%HAND_YOLO%" (
    echo hand_yolov9c.bat does not exist: "%HAND_YOLO%"
    exit /b 1
)

if not exist "%FACE_SEGM%" (
    echo AnzhcFace-v2-768MS-seg.bat does not exist: "%FACE_SEGM%"
    exit /b 1
)

call "%FACE_YOLO%"
if errorlevel 1 (
    echo Failed to download face_yolov9c.
    exit /b 1
)

call "%HAND_YOLO%"
if errorlevel 1 (
    echo Failed to download hand_yolov9c.
    exit /b 1
)

call "%FACE_SEGM%"
if errorlevel 1 (
    echo Failed to download AnzhcFace-v2-768MS-seg.
    exit /b 1
)

exit /b 0
