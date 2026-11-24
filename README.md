# 📂 Organizador Automático de Descargas

Programa en Python que organiza automáticamente los archivos de la carpeta Descargas, clasificándolos según su tipo para mantener todo ordenado.

## 🚀 Funcionalidades

- 📄 Clasificación automática de documentos y PDF.
- 🖼️ Organización de imágenes.
- 💿 Separación de instaladores.
- 📦 Organización de archivos comprimidos.
- 🎵 Clasificación de música.
- 🎬 Clasificación de videos.
- 🔄 Revisión automática cada 30 segundos.
- 🛡️ Evita mover archivos que todavía se están descargando.
- 🔁 Evita sobrescribir archivos con el mismo nombre.
- ⚡ Posibilidad de ejecutarse automáticamente al iniciar Windows.

## 📁 Estructura de carpetas

Los archivos se organizan dentro de una carpeta llamada `organizador`:

```text
Descargas/
└── organizador/
    ├── Documentos/
    ├── Imágenes/
    ├── Instaladores/
    ├── Comprimidos/
    ├── Música/
    └── Videos/
```

## ⚙️ Requisitos

- Windows 10/11.
- Python instalado.

## ▶️ Ejecución manual

Ejecutar el archivo desde una terminal:

```bash
python organizador_descargas.py
```

El programa comenzará a revisar la carpeta Descargas y organizará los archivos automáticamente cada 30 segundos.

Para detenerlo, se utilizará la combinación:

`CTRL + SHIFT + F12`

> Esta combinación de detención personalizada está prevista para implementarse en el código.

## 🔄 Inicio automático

El proyecto incluye un script de PowerShell:

`instalar_inicio_automatico.ps1`

Este script configura una tarea programada de Windows para iniciar el organizador automáticamente al iniciar sesión, sin necesidad de ejecutarlo manualmente cada vez.

## 🛠️ Tecnologías utilizadas

- Python
- pathlib
- shutil
- PowerShell
- Windows Task Scheduler

---

Proyecto personal de automatización desarrollado en Python.
