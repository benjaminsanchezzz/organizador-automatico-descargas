# ============================================
# ORGANIZADOR AUTOMATICO - INICIO DE WINDOWS
# ============================================

$NombreTarea = "Organizador Automatico de Descargas"

$CarpetaProyecto = "C:\organizador"

$ScriptPython = Join-Path $CarpetaProyecto "organizador_descargas.py"

$Python = "C:\Users\Usuario\AppData\Local\Python\pythoncore-3.15-64\python.exe"

$PythonW = "C:\Users\Usuario\AppData\Local\Python\pythoncore-3.15-64\pythonw.exe"

# Comprobar que exista el script
if (-not (Test-Path $ScriptPython)) {
    Write-Host "ERROR: No se encuentra el archivo Python:"
    Write-Host $ScriptPython
    Read-Host "Presioná Enter para salir"
    exit
}

# Comprobar Python
if (-not (Test-Path $Python)) {
    Write-Host "ERROR: No se encontró Python:"
    Write-Host $Python
    Read-Host "Presioná Enter para salir"
    exit
}

# Si no existe pythonw, usar python
if (-not (Test-Path $PythonW)) {
    $PythonW = $Python
}

# Crear acción
$Accion = New-ScheduledTaskAction `
    -Execute $PythonW `
    -Argument "`"$ScriptPython`"" `
    -WorkingDirectory $CarpetaProyecto

# Activar al iniciar sesión en Windows
$Trigger = New-ScheduledTaskTrigger -AtLogOn

# Configuración de la tarea
$Configuracion = New-ScheduledTaskSettingsSet `
    -StartWhenAvailable `
    -ExecutionTimeLimit ([TimeSpan]::Zero)

# Registrar la tarea
Register-ScheduledTask `
    -TaskName $NombreTarea `
    -Action $Accion `
    -Trigger $Trigger `
    -Settings $Configuracion `
    -Description "Organiza automaticamente los archivos de Descargas." `
    -Force

Write-Host ""
Write-Host "============================================"
Write-Host " INSTALACION COMPLETADA"
Write-Host "============================================"
Write-Host "El organizador se iniciara al iniciar sesion."
Write-Host ""

Read-Host "Presiona Enter para cerrar"
