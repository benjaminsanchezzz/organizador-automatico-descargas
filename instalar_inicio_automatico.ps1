
# ============================================
# ORGANIZADOR AUTOMATICO - INICIO DE WINDOWS
# ============================================

$NombreTarea = "Organizador Automatico de Descargas"

$CarpetaProyecto = Split-Path -Parent $MyInvocation.MyCommand.Path

$ScriptPython = Join-Path $CarpetaProyecto "organizador_descargas.py"

# Buscar Python automaticamente
$Python = (Get-Command python.exe -ErrorAction SilentlyContinue).Source

if (-not $Python) {
    $Python = (Get-Command py.exe -ErrorAction SilentlyContinue).Source
}

if (-not $Python) {
    Write-Host "ERROR: No se encontro Python."
    Read-Host "Presiona Enter para salir"
    exit 1
}

# Buscar pythonw.exe
$PythonW = Join-Path (Split-Path $Python) "pythonw.exe"

if (-not (Test-Path $PythonW)) {
    $PythonW = $Python
}

# Comprobar que exista el script
if (-not (Test-Path $ScriptPython)) {
    Write-Host "ERROR: No se encuentra organizador_descargas.py"
    Read-Host "Presiona Enter para salir"
    exit 1
}

# Crear accion
$Accion = New-ScheduledTaskAction `
    -Execute $PythonW `
    -Argument "`"$ScriptPython`"" `
    -WorkingDirectory $CarpetaProyecto

# Iniciar al iniciar sesion
$Trigger = New-ScheduledTaskTrigger -AtLogOn

# Configuracion
$Configuracion = New-ScheduledTaskSettingsSet `
    -StartWhenAvailable `
    -ExecutionTimeLimit ([TimeSpan]::Zero)

# Registrar tarea
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
