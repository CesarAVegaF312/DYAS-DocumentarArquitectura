#!/usr/bin/env bash
# Verifica que los diagramas de docs/diagramas/ correspondan al modelo actual.
# Falla si alguien cambió workspace.dsl y olvidó ejecutar scripts/exportar.sh (documentación desactualizada).
source "$(dirname "$0")/comun.sh"

temporal="$(mktemp -d)"
trap 'rm -rf "$temporal"' EXIT

scripts/exportar.sh "$temporal" > /dev/null
if ! diff -r "$DIAGRAMAS" "$temporal" > "$temporal.diff"; then
    echo "Los diagramas de $DIAGRAMAS no corresponden a $MODELO:"
    cat "$temporal.diff"
    rm -f "$temporal.diff"
    echo "Ejecute scripts/exportar.sh y haga commit de los cambios."
    exit 1
fi
rm -f "$temporal.diff"
echo "Los diagramas de $DIAGRAMAS están al día con el modelo."
