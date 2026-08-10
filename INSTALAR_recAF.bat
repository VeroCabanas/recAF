@echo off
chcp 65001 > nul
setlocal

set "RECAF_ROOT=%~dp0"
where Rscript >nul 2>&1
if errorlevel 1 (
    echo Error: Rscript no se encuentra en el PATH del sistema.
    echo Instale R 4.4 o posterior antes de continuar.
    pause
    exit /b 1
)

Rscript "%RECAF_ROOT%scripts\instalar_dependencias.R"
set "RECAF_EXIT=%ERRORLEVEL%"

if not "%RECAF_EXIT%"=="0" (
    echo.
    echo La instalación no terminó correctamente.
    pause
    exit /b %RECAF_EXIT%
)

echo.
echo Dependencias instaladas correctamente.
pause
exit /b 0
