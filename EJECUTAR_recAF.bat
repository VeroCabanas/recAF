@echo off
chcp 65001 > nul
setlocal

set "RECAF_ROOT=%~dp0"
where Rscript >nul 2>&1
if errorlevel 1 (
    echo Error: Rscript no se encuentra en el PATH del sistema.
    echo Instale R y vuelva a ejecutar recAF.
    pause
    exit /b 1
)

Rscript "%RECAF_ROOT%scripts\ejecutar_recaf.R" --input-dir "%RECAF_ROOT%data\input" --output-dir "%RECAF_ROOT%results"
set "RECAF_EXIT=%ERRORLEVEL%"

if not "%RECAF_EXIT%"=="0" (
    echo.
    echo recAF terminó con errores. Consulte el registro de procesamiento.
    pause
    exit /b %RECAF_EXIT%
)

echo.
echo Procesamiento finalizado. Consulte la carpeta results.
pause
exit /b 0

