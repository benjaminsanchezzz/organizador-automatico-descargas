# ============================================
# ORGANIZADOR AUTOMATICO - INICIO DE WINDOWS
# ============================================

$NombreTarea = "Organizador Automatico de Descargas"

$CarpetaProyecto = Split-Path -Parent $MyInvocation.MyCommand.Path

$Ejecutable = Join-Path $CarpetaProyecto "dist\OrganizadorDescargas.exe"

# Comprobar que exista el ejecutable
if (-not (Test-Path $Ejecutable)) {
    Write-Host "ERROR: No se encuentra OrganizadorDescargas.exe"
    Write-Host "Ruta esperada: $Ejecutable"
    Read-Host "Presiona Enter para salir"
    exit 1
}

# Crear accion: ejecutar el EXE
$Accion = New-ScheduledTaskAction `
    -Execute $Ejecutable `
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
