# Taller de Documentación de la Arquitectura

## Objetivo General

Documentar la arquitectura de un sistema real como **código versionado**: diagramas con el **modelo C4** escritos en Structurizr DSL, decisiones registradas como **ADR** y un documento de arquitectura basado en **arc42**, verificados automáticamente en un pipeline para que la documentación no se desactualice.

## Índice

- [Conceptos clave](#conceptos-clave)
- [CONOCE EL TALLER](#conoce-el-taller)
  - [Requisitos](#requisitos)
  - [Estructura del proyecto](#estructura-del-proyecto)
- [PASO A PASO](#paso-a-paso)
  - [Paso 1: Levantar el visor y estudiar el ejemplo](#paso-1-levantar-el-visor-y-estudiar-el-ejemplo)
  - [Paso 2: Diagrama de contenedores](#paso-2-diagrama-de-contenedores)
  - [Paso 3: Diagrama de componentes](#paso-3-diagrama-de-componentes)
  - [Paso 4: Vista dinámica](#paso-4-vista-dinámica)
  - [Paso 5: Vista de despliegue](#paso-5-vista-de-despliegue)
  - [Paso 6: Decisiones y documento de arquitectura](#paso-6-decisiones-y-documento-de-arquitectura)
  - [Paso 7: Pipeline de documentación](#paso-7-pipeline-de-documentación)
- [Retos opcionales](#retos-opcionales)
- [Buenas prácticas](#buenas-prácticas)
- [Para entregar](#para-entregar-con-este-taller)
- [Resumen del taller](#hagamos-un-resumen)
- [Recursos recomendados](#recursos-recomendados)
- [Créditos y uso académico](#créditos-y-uso-académico)
- [Licencia](#licencia-de-uso)

---

## Conceptos clave

| Concepto | Qué es |
|---|---|
| **Modelo C4** | Forma de describir la arquitectura de software de Simon Brown, en cuatro niveles de zoom: **contexto** (el sistema y su entorno), **contenedores** (lo que se despliega por separado), **componentes** (las partes de un contenedor) y **código**. |
| **Diagramas como código** | Los diagramas se escriben en texto, se versionan con git y se revisan en un Pull Request, igual que el código. |
| **Structurizr DSL** | Lenguaje para describir **un modelo** del que salen todas las vistas. Un elemento se declara una vez y aparece en todos los diagramas que lo incluyen. |
| **ADR** (*Architecture Decision Record*) | Documento corto que registra una decisión de arquitectura: el contexto, la decisión, las alternativas y las consecuencias. No se edita después de aceptado: si cambia la decisión, se escribe uno nuevo que lo reemplaza. |
| **arc42** | Plantilla de documento de arquitectura con secciones estándar (objetivos, restricciones, vistas, decisiones, calidad, riesgos). |
| **Escenario de calidad** | Requisito de calidad medible con la forma: fuente, estímulo, entorno, respuesta y medida. |
| **Documentación desactualizada** | Documentación que ya no corresponde al sistema. Aquí se evita verificando en el pipeline que los diagramas exportados salen del modelo actual. |

---

## CONOCE EL TALLER

Va a documentar el **servicio de reservas de salas** del taller [DYAS-ArquitecturaHexagonal](https://github.com/CesarAVegaF312/DYAS-ArquitecturaHexagonal), en su versión terminada: API REST en Spring Boot con arquitectura hexagonal, adaptador de PostgreSQL y puerto de notificaciones. Tenga a mano su solución de ese taller: la documentación debe describir el sistema que existe, no uno imaginario.

El repositorio trae resueltos, como ejemplo:

- El **diagrama de contexto** en `docs/c4/workspace.dsl`.
- El **ADR-0001** sobre la arquitectura hexagonal.
- La **sección 1** del documento de arquitectura (`docs/arquitectura.md`).

Su trabajo es completar el resto del modelo, escribir dos ADR nuevos y terminar el documento.

Las herramientas corren en Docker con la imagen oficial `structurizr/structurizr`, así que no hay que instalar nada más:

| Comando | Qué hace |
|---|---|
| `docker compose up -d` | Levanta el **visor** en [http://localhost:8080](http://localhost:8080): muestra los diagramas y los actualiza al recargar la página. |
| `scripts/validar.sh` | Valida la sintaxis y las referencias del modelo. |
| `scripts/exportar.sh` | Exporta cada vista a un archivo Markdown con un diagrama Mermaid en `docs/diagramas/`. GitHub los muestra como diagramas. |
| `scripts/verificar-diagramas.sh` | Falla si los diagramas de `docs/diagramas/` no corresponden al modelo actual. |
| `scripts/verificar-adr.sh` | Falla si un ADR no sigue el formato de la plantilla. |

### Requisitos

- Docker Desktop o Docker Engine con Docker Compose v2.
- Git, una terminal con Bash (en Windows, Git Bash o WSL) y un editor. El repositorio trae un contenedor de desarrollo (`.devcontainer/`) con todo listo para GitHub Codespaces o VS Code.
- Haber hecho el taller de [arquitectura hexagonal](https://github.com/CesarAVegaF312/DYAS-ArquitecturaHexagonal).

### Estructura del proyecto

```text
.
├── compose.yaml                     # visor local de Structurizr
├── docs/
│   ├── arquitectura.md              # documento de arquitectura (arc42 reducido)
│   ├── c4/
│   │   └── workspace.dsl            # modelo C4: lo completa en los Pasos 2 a 5
│   ├── adr/
│   │   ├── 0000-plantilla.md        # plantilla de ADR
│   │   └── 0001-arquitectura-hexagonal.md   # ejemplo resuelto
│   └── diagramas/                   # generados por scripts/exportar.sh: no se editan a mano
├── scripts/                         # validar, exportar y verificar
└── .github/workflows/documentacion.yml      # pipeline que corre los scripts de verificación
```

---

## PASO A PASO

### Paso 1: Levantar el visor y estudiar el ejemplo

1. Haga un *fork* del repositorio y clónelo:

   ```bash
   git clone https://github.com/<tu-usuario>/DYAS-DocumentarArquitectura.git
   cd DYAS-DocumentarArquitectura
   ```

2. Levante el visor y abra [http://localhost:8080](http://localhost:8080):

   ```bash
   docker compose up -d
   ```

   > En Linux, si el visor no arranca y `docker compose logs visor` dice *Data directory ... is not writable*, cree un archivo `.env` con `USUARIO_ID` y `GRUPO_ID` iguales a la salida de `id -u` e `id -g`, y vuelva a levantarlo.

3. Abra `docs/c4/workspace.dsl` y compárelo con el diagrama de contexto en el visor. Responda en su informe:
   1. ¿Qué diferencia hay entre el **modelo** (la sección `model`) y las **vistas** (la sección `views`)?
   2. ¿Por qué el sistema de correo tiene la etiqueta `Externo` y qué efecto tiene en el diagrama?
   3. ¿Qué ventajas tiene escribir el diagrama en texto frente a dibujarlo en una herramienta gráfica? ¿Qué desventajas?

4. Ejecute los scripts de verificación. Todos deben pasar:

   ```bash
   scripts/validar.sh
   scripts/verificar-diagramas.sh
   scripts/verificar-adr.sh
   ```

5. Abra `docs/diagramas/Contexto.md` en GitHub (en su *fork*) y compruebe que se ve el diagrama.

### Paso 2: Diagrama de contenedores

Dentro del sistema `reservas` declare los contenedores del sistema de reservas, con descripción y tecnología:

- La **API de reservas**, en Java 21 y Spring Boot 4.1.
- La **base de datos**, en PostgreSQL 18, con la etiqueta `Base de datos` para que se dibuje como cilindro.

Agregue las relaciones con su tecnología: el estudiante usa la API (JSON/HTTPS), la API lee y escribe en la base de datos (JDBC) y envía avisos al correo (SMTP). Cree la vista `container reservas "Contenedores"` con `include *` y `autolayout lr`.

Recargue el visor después de cada cambio. Si algo no aparece, ejecute `scripts/validar.sh`: el mensaje indica la línea con el error.

### Paso 3: Diagrama de componentes

Dentro del contenedor de la API declare los componentes del hexágono, agrupados con `group` según su capa:

| Grupo | Componentes |
|---|---|
| Adaptadores de entrada | `ReservaController` |
| Aplicación | `ServicioReservas` |
| Dominio | `Reserva` |
| Adaptadores de salida | `RepositorioReservasPostgres`, `NotificadorPorLog` |

Las relaciones deben nombrar el **puerto** por el que pasan (por ejemplo, «Guarda y consulta por el puerto RepositorioReservas») y conectar los adaptadores de salida con la base de datos y el correo. Cree la vista `component reservas.api "Componentes"`.

Compare el diagrama con su código del taller hexagonal: cada componente debe existir con ese nombre y cada relación debe corresponder a una dependencia real.

### Paso 4: Vista dinámica

Cree la vista `dynamic reservas.api "CrearReserva"` con el flujo de `POST /api/reservas` cuando la sala está libre: desde el estudiante hasta el aviso, pasando por la validación en el dominio, la consulta de cruces y el guardado. Cada paso debe describir la operación (por ejemplo, `buscarPorSalaYFecha(...)`).

### Paso 5: Vista de despliegue

Declare el entorno `deploymentEnvironment "Local"` con los nodos de Docker Compose del taller hexagonal: el equipo del desarrollador, un contenedor para la aplicación (`eclipse-temurin:21-jre`) y otro para PostgreSQL (`postgres:18.6-alpine`), cada uno con su `containerInstance`. Cree la vista `deployment reservas local "Despliegue"`.

Cuando termine el modelo, exporte los diagramas y compruebe que la verificación pasa:

```bash
scripts/validar.sh
scripts/exportar.sh
scripts/verificar-diagramas.sh
```

### Paso 6: Decisiones y documento de arquitectura

1. A partir de `docs/adr/0000-plantilla.md`, escriba dos ADR:
   - `0002-...`: guardar las reservas en PostgreSQL con JDBC (frente a mantenerlas en memoria o usar JPA).
   - `0003-...`: avisar al responsable por un puerto de notificaciones (frente a hacerlo directamente en el caso de uso).

   Cada uno con al menos dos alternativas reales y consecuencias negativas, no solo positivas. Verifique el formato con `scripts/verificar-adr.sh`.

2. Complete las secciones 2 a 10 de `docs/arquitectura.md`, reemplazando cada `TODO`. Los diagramas se enlazan desde `docs/diagramas/`; no copie imágenes.

3. Los escenarios de calidad de la sección 9 deben ser **medibles**. Por ejemplo, para mantenibilidad: «Un desarrollador (fuente) necesita guardar las reservas en otra base de datos (estímulo) durante el desarrollo (entorno); lo logra escribiendo un adaptador nuevo sin modificar el dominio ni los casos de uso (respuesta), en menos de un día y con las pruebas de arquitectura en verde (medida)».

### Paso 7: Pipeline de documentación

1. Haga commit y push de su trabajo y revise la pestaña **Actions** de su *fork*: el workflow **Documentación** debe terminar en verde.
2. Compruebe que el pipeline detecta documentación desactualizada: cambie la descripción de una relación en `workspace.dsl` **sin** ejecutar `scripts/exportar.sh`, haga push y observe el fallo. Luego exporte, haga commit y verifique que vuelve a verde. Incluya en el informe el enlace a las dos ejecuciones.

---

## Retos opcionales

1. **Diagramas en el Pull Request.** Agregue al workflow un paso que exporte los diagramas a PNG y los publique como *artifact* de la ejecución.
2. **Documentación que se verifica contra el código.** Agregue al taller hexagonal una prueba de ArchUnit que falle si aparece en el paquete `adaptadores` una clase que no está declarada como componente en `workspace.dsl`. ¿Qué tan frágil es esa prueba?
3. **Modelo de varios sistemas.** Modele el sistema completo de la biblioteca (préstamos, catálogo, reservas) como un *system landscape* y ubique el servicio de reservas dentro de él.

---

## Buenas prácticas

- Un diagrama sin título, leyenda o tecnología en las relaciones obliga a adivinar. Cada elemento lleva descripción y cada relación su protocolo.
- Un elemento se declara una sola vez en el modelo; las vistas solo eligen qué mostrar.
- Los ADR son inmutables una vez aceptados. Si una decisión cambia, se escribe un ADR nuevo que la reemplaza y se actualiza el estado del anterior.
- La documentación vive junto al código y cambia en el mismo Pull Request que el código que describe.
- Los archivos de `docs/diagramas/` son generados: se regeneran con `scripts/exportar.sh`, no se editan.

---

## PARA ENTREGAR CON ESTE TALLER

Entregue el enlace a su *fork* con un `INFORME.md` en la raíz que incluya las respuestas del Paso 1 y los enlaces a las dos ejecuciones del pipeline del Paso 7. Antes de entregar, este comando no debe mostrar nada:

```bash
grep -rn "TODO" docs/
```

### Criterios de evaluación

| Criterio | Qué se revisa | Peso |
|---|---|---|
| **Modelo C4** | Las vistas de contenedores, componentes, dinámica y despliegue existen y corresponden al sistema real del taller hexagonal (nombres, tecnologías y dependencias). Las relaciones indican protocolo o puerto. | 35 % |
| **ADR** | ADR-0002 y ADR-0003 siguen la plantilla, tienen al menos dos alternativas reales y consecuencias negativas además de las positivas. | 20 % |
| **Documento de arquitectura** | Las secciones 2 a 10 están completas, enlazan los diagramas generados y los escenarios de calidad son medibles. | 25 % |
| **Pipeline** | El workflow **Documentación** pasa en la rama principal y se demostró que detecta diagramas desactualizados. | 10 % |
| **Informe** | Respuestas del Paso 1 y evidencia del Paso 7. | 10 % |

---

## Hagamos un resumen

- El modelo C4 describe la arquitectura en niveles de zoom: contexto, contenedores, componentes y código.
- Con Structurizr DSL se escribe un modelo y se generan varias vistas a partir de él.
- Los ADR registran por qué se tomó cada decisión, con sus alternativas y sus costos.
- arc42 organiza el resto de la documentación alrededor de los objetivos de calidad.
- Si la documentación se verifica en el pipeline, no se queda atrás del sistema.

---

## Recursos recomendados

- Simon Brown: [El modelo C4](https://c4model.com/)
- [Structurizr DSL: referencia del lenguaje](https://docs.structurizr.com/dsl/language)
- Michael Nygard: [Documenting Architecture Decisions](https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions)
- [arc42: descripción de las secciones](https://arc42.org/overview)
- Len Bass, Paul Clements y Rick Kazman: *Software Architecture in Practice*, capítulo sobre atributos y escenarios de calidad.
- [GitHub: diagramas Mermaid en Markdown](https://docs.github.com/es/get-started/writing-on-github/working-with-advanced-formatting/creating-diagrams)

---

## Créditos y uso académico

**Autor:** César Augusto Vega Fernández
**Curso:** Diseño y Arquitectura de Software, Universidad de La Sabana

## Licencia de uso

Este material se distribuye bajo la licencia [Creative Commons Atribución-NoComercial-CompartirIgual 4.0 Internacional (CC BY-NC-SA 4.0)](https://creativecommons.org/licenses/by-nc-sa/4.0/deed.es).
