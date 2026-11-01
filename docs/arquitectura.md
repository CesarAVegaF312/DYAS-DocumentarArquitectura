# Documento de arquitectura: servicio de reservas de salas

Estructura basada en [arc42](https://arc42.org/overview), reducida a las secciones que pide el taller.
Los diagramas se generan desde [`c4/workspace.dsl`](c4/workspace.dsl) con `scripts/exportar.sh`; no los dibuje a mano.

## 1. Introducción y objetivos

*Ejemplo resuelto.*

La biblioteca de la universidad necesita que los estudiantes reserven salas de estudio sin cruces de horario
y respetando sus reglas (horario de 07:00 a 21:00, máximo 3 horas, correo institucional). El servicio de reservas
expone esos casos de uso por una API REST.

Objetivos de calidad, en orden de prioridad:

| Prioridad | Atributo | Qué significa para este sistema |
|---|---|---|
| 1 | Mantenibilidad | Cambiar la base de datos o el canal de avisos sin modificar las reglas de negocio. |
| 2 | Correctitud | Nunca aceptar una reserva que incumpla las reglas o se cruce con otra activa. |
| 3 | Facilidad de prueba | Probar las reglas de negocio en segundos, sin base de datos ni servidor web. |

Partes interesadas: estudiantes (reservan), personal de la biblioteca (define las reglas) y el equipo de
desarrollo, que cambia cada semestre.

## 2. Restricciones

TODO (Paso 6): restricciones técnicas y organizacionales que no decide el equipo (lenguaje, plataforma,
despliegue, normas de la universidad...). Mínimo tres, en una tabla con su motivo.

## 3. Contexto del sistema

TODO (Paso 6): enlace a [la vista de contexto](diagramas/Contexto.md) y una tabla con cada actor o sistema
externo, qué intercambia con el sistema y por qué medio.

## 4. Estrategia de solución

TODO (Paso 6): las decisiones de fondo en pocas líneas (estilo de arquitectura, tecnologías principales) y
cómo cada una apoya un objetivo de calidad de la sección 1. Enlace a los ADR que las justifican.

## 5. Vista de bloques

TODO (Paso 6): enlaces a las vistas de [contenedores](diagramas/Contenedores.md) y
[componentes](diagramas/Componentes.md), y una tabla con la responsabilidad de cada componente.

## 6. Vista de ejecución

TODO (Paso 6): enlace a la vista dinámica [CrearReserva](diagramas/CrearReserva.md) y la explicación del flujo,
incluido qué pasa cuando la sala está ocupada.

## 7. Vista de despliegue

TODO (Paso 6): enlace a la [vista de despliegue](diagramas/Despliegue.md) y cómo se levanta el sistema.

## 8. Decisiones de arquitectura

TODO (Paso 6): lista de los ADR de [`adr/`](adr/) con su estado.

## 9. Escenarios de calidad

TODO (Paso 6): al menos tres escenarios medibles, uno por cada objetivo de calidad de la sección 1, con la
forma: fuente, estímulo, entorno, respuesta y medida de la respuesta.

## 10. Riesgos y deuda técnica

TODO (Paso 6): riesgos conocidos con su impacto y cómo mitigarlos. Incluya el de las reservas simultáneas
que menciona el ADR-0001.
