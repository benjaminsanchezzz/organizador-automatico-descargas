import shutil
import time
from pathlib import Path

# ==================================================
# CONFIGURACIÓN
# ==================================================

# Tu carpeta real de Descargas
DESCARGAS = Path(r"D:\Datos Usuario\Descargas")

# Carpeta donde se organizarán los archivos
DESTINO = DESCARGAS / "organizador"

# Tiempo entre revisiones (segundos)
INTERVALO = 30

# Tiempo para comprobar que un archivo terminó de descargarse
TIEMPO_ESTABILIDAD = 2


# ==================================================
# CATEGORÍAS
# ==================================================

CATEGORIAS = {
    "Documentos": [
        ".pdf",
    ],

    "Imágenes": [
        ".jpg", ".jpeg", ".png", ".gif",
        ".webp", ".bmp", ".svg", ".tiff",
    ],

    "Instaladores": [
        ".exe", ".msi", ".msix", ".msixbundle",
        ".appx", ".appxbundle",
    ],

    "Comprimidos": [
        ".zip", ".rar", ".7z", ".tar",
        ".gz", ".bz2", ".xz",
    ],

    "Música": [
        ".mp3", ".wav", ".flac",
        ".aac", ".ogg", ".m4a",
    ],

    "Videos": [
        ".mp4", ".mkv", ".mov", ".avi",
        ".webm", ".wmv", ".m4v",
    ],
}


# ==================================================
# BUSCAR CATEGORÍA
# ==================================================

def obtener_categoria(archivo):
    extension = archivo.suffix.lower()

    for categoria, extensiones in CATEGORIAS.items():
        if extension in extensiones:
            return categoria

    return None


# ==================================================
# EVITAR ARCHIVOS DUPLICADOS
# ==================================================

def evitar_duplicados(ruta_destino):
    if not ruta_destino.exists():
        return ruta_destino

    nombre = ruta_destino.stem
    extension = ruta_destino.suffix
    contador = 1

    while True:
        nuevo_nombre = f"{nombre} ({contador}){extension}"

        nueva_ruta = ruta_destino.with_name(nuevo_nombre)

        if not nueva_ruta.exists():
            return nueva_ruta

        contador += 1


# ==================================================
# COMPROBAR SI EL ARCHIVO TERMINÓ DE DESCARGARSE
# ==================================================

def archivo_estable(archivo):
    try:
        tamaño_inicial = archivo.stat().st_size

        time.sleep(TIEMPO_ESTABILIDAD)

        tamaño_final = archivo.stat().st_size

        return tamaño_inicial == tamaño_final

    except (PermissionError, FileNotFoundError, OSError):
        return False


# ==================================================
# ORGANIZAR ARCHIVOS
# ==================================================

def organizar_descargas():

    if not DESCARGAS.exists():
        print(f"[ERROR] No existe la carpeta: {DESCARGAS}")
        return

    archivos_movidos = 0

    try:
        archivos = list(DESCARGAS.iterdir())
    except PermissionError:
        print("[ERROR] No se puede acceder a Descargas.")
        return

    for archivo in archivos:

        # Ignorar carpetas
        if not archivo.is_file():
            continue

        # Ignorar archivos que ya están dentro del organizador
        if archivo.parent == DESTINO:
            continue

        # Buscar categoría
        categoria = obtener_categoria(archivo)

        # Si no tiene categoría, no hacer nada
        if categoria is None:
            continue

        # Comprobar si terminó de descargarse
        if not archivo_estable(archivo):
            print(f"[ESPERANDO] {archivo.name}")
            continue

        # Crear carpeta de destino
        carpeta_destino = DESTINO / categoria

        carpeta_destino.mkdir(parents=True, exist_ok=True)

        # Evitar sobrescribir archivos
        ruta_final = evitar_duplicados(
            carpeta_destino / archivo.name
        )

        # Mover archivo
        try:
            shutil.move(str(archivo), str(ruta_final))

            print(f"[MOVIDO] {archivo.name} -> {categoria}")

            archivos_movidos += 1

        except PermissionError:
            print(f"[ERROR] Sin permisos: {archivo.name}")

        except OSError as error:
            print(f"[ERROR] {archivo.name}: {error}")

    if archivos_movidos == 0:
        print("[INFO] No hay archivos nuevos para organizar.")

    else:
        print(f"[OK] Se organizaron {archivos_movidos} archivos.")


# ==================================================
# PROGRAMA PRINCIPAL
# ==================================================

def main():

    print("=" * 45)
    print("       ORGANIZADOR AUTOMÁTICO")
    print("=" * 45)

    print(f"Descargas: {DESCARGAS}")
    print(f"Destino:   {DESTINO}")
    print(f"Intervalo: {INTERVALO} segundos")
    print()

    if not DESCARGAS.exists():
        print("[ERROR] No se encontró tu carpeta Descargas.")
        print(f"Ruta comprobada: {DESCARGAS}")
        input("\nPresioná Enter para cerrar.")
        return

    print("[FUNCIONANDO] Organizador iniciado.")
    print("Presioná CTRL + C para detener.")
    print("=" * 45)

    try:

        while True:

            organizar_descargas()

            print(f"\nPróxima revisión en {INTERVALO} segundos...\n")

            time.sleep(INTERVALO)

    except KeyboardInterrupt:

        print("\n")
        print("=" * 45)
        print("Organizador detenido correctamente.")
        print("=" * 45)


# ==================================================
# INICIAR
# ==================================================

if __name__ == "__main__":
    main()