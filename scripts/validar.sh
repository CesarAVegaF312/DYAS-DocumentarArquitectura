#!/usr/bin/env bash
# Valida la sintaxis y las referencias del modelo C4 (docs/c4/workspace.dsl).
source "$(dirname "$0")/comun.sh"

if ! salida="$(docker run --rm -v "$PWD/docs/c4:/c4:ro" "$IMAGEN" validate -w "/c4/workspace.dsl" 2>&1)"; then
    echo "$salida" | grep -E "ERROR|Exception" | sed 's/^.*ERROR [^ ]* -- //' | head -n 5
    echo "El modelo $MODELO tiene errores."
    exit 1
fi
echo "El modelo $MODELO es válido."
