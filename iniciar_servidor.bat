@echo off
TITLE ngrok Static Server
echo ==========================================
echo Intentando iniciar ngrok como servidor...
echo ==========================================

:: Usamos la ruta actual del archivo .bat
set "FOLDER_PATH=%~dp0"

:: Limpiamos la ruta para que use barras invertidas / como pide ngrok
set "CLEAN_PATH=%FOLDER_PATH:\=/%"

echo Ruta detectada: %FOLDER_PATH%
echo Comando sugerido: ngrok http "file:///%CLEAN_PATH%"
echo.
echo Presiona una tecla para intentar abrir el tunel...
pause

:: Ejecutamos ngrok directamente. No usamos start para ver errores en esta ventana.
ngrok http "file:///%CLEAN_PATH%"

if %ERRORLEVEL% neq 0 (
    echo.
    echo ------------------------------------------
    echo ERROR: No se pudo iniciar ngrok.
    echo Asegurate de que ngrok este instalado correctamente.
    echo ------------------------------------------
)

pause
