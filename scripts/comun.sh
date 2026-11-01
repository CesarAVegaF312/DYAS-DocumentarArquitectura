# Configuración compartida por los scripts. Se incluye con: source "$(dirname "$0")/comun.sh"
set -euo pipefail
cd "$(dirname "$0")/.."

# Imagen oficial de Structurizr (validar, exportar y visor local), con versión fija.
IMAGEN="${STRUCTURIZR_IMAGEN:-structurizr/structurizr:2026.09.19}"
MODELO="docs/c4/workspace.dsl"
DIAGRAMAS="docs/diagramas"

# El contenedor corre con el usuario actual para poder escribir en las carpetas del proyecto.
USUARIO="$(id -u):$(id -g)"
