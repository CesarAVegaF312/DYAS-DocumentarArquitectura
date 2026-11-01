#!/usr/bin/env bash
# Verifica que cada ADR de docs/adr/ siga el formato de la plantilla (0000-plantilla.md):
# nombre NNNN-titulo.md, título "# ADR-NNNN. ...", un estado válido y las secciones obligatorias.
source "$(dirname "$0")/comun.sh"

estados='Propuesta|Aceptada|Rechazada|Reemplazada por ADR-[0-9]{4}'
secciones=("## Contexto" "## Decisión" "## Alternativas consideradas" "## Consecuencias")
errores=0
total=0

for adr in docs/adr/[0-9][0-9][0-9][0-9]-*.md; do
    nombre="$(basename "$adr")"
    numero="${nombre:0:4}"
    [ "$numero" = "0000" ] && continue
    total=$((total + 1))

    if ! [[ "$nombre" =~ ^[0-9]{4}-[a-z0-9-]+\.md$ ]]; then
        echo "$adr: el nombre debe tener la forma NNNN-titulo-en-minusculas.md"
        errores=$((errores + 1))
    fi
    if ! head -n 1 "$adr" | grep -Eq "^# ADR-$numero\. .+"; then
        echo "$adr: la primera línea debe ser \"# ADR-$numero. Título\""
        errores=$((errores + 1))
    fi
    if ! grep -Eq "^\*\*Estado:\*\* ($estados)\s*$" "$adr"; then
        echo "$adr: falta la línea \"**Estado:** ...\" con un estado válido (Propuesta, Aceptada, Rechazada o Reemplazada por ADR-NNNN)"
        errores=$((errores + 1))
    fi
    for seccion in "${secciones[@]}"; do
        if ! grep -Fxq "$seccion" "$adr"; then
            echo "$adr: falta la sección \"$seccion\""
            errores=$((errores + 1))
        fi
    done
done

if [ "$errores" -gt 0 ]; then
    echo "Se encontraron $errores problemas en los ADR."
    exit 1
fi
echo "Los $total ADR tienen el formato correcto."
