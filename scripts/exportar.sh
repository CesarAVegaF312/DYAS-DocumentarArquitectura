#!/usr/bin/env bash
# Exporta cada vista del modelo C4 a Mermaid, en un archivo Markdown por vista dentro de docs/diagramas/.
# GitHub muestra los bloques Mermaid como diagramas. Uso: scripts/exportar.sh [carpeta de salida]
source "$(dirname "$0")/comun.sh"

salida="${1:-$DIAGRAMAS}"
temporal="$(mktemp -d)"
trap 'rm -rf "$temporal"' EXIT

docker run --rm --user "$USUARIO" -v "$PWD/docs/c4:/c4:ro" -v "$temporal:/salida" \
    "$IMAGEN" export -w /c4/workspace.dsl -f mermaid -o /salida > /dev/null

mkdir -p "$salida"
find "$salida" -maxdepth 1 -name '*.md' -delete
for archivo in "$temporal"/structurizr-*.mmd; do
    vista="$(basename "$archivo" .mmd)"
    vista="${vista#structurizr-}"
    {
        echo "# Vista: $vista"
        echo
        echo "Generado con \`scripts/exportar.sh\` a partir de \`$MODELO\`. No lo edite a mano."
        echo
        echo '```mermaid'
        # awk agrega el salto de línea final que no trae el archivo exportado, para cerrar bien el bloque.
        awk '1' "$archivo"
        echo '```'
    } > "$salida/$vista.md"
    echo "Exportada la vista $vista -> $salida/$vista.md"
done
