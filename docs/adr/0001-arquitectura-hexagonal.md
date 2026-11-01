# ADR-0001. Usar arquitectura hexagonal en el servicio de reservas

**Estado:** Aceptada
**Fecha:** 2026-10-06

## Contexto

El servicio de reservas debe poder cambiar de mecanismo de entrada (hoy una API REST; en el futuro, por ejemplo,
un bot o una cola de mensajes) y de almacenamiento (hoy en memoria, luego PostgreSQL) sin reescribir las reglas
de negocio: horario de la biblioteca, duración máxima, correo institucional y cruces entre reservas.

Las reglas de negocio deben poder probarse de forma aislada, sin base de datos ni servidor web, y el equipo
cambia cada semestre, así que las fronteras entre capas deben ser evidentes y verificables.

## Decisión

Usamos arquitectura hexagonal (puertos y adaptadores) con estos paquetes:

| Paquete | Contenido | Puede depender de |
|---|---|---|
| `dominio` | `Reserva` y las excepciones de negocio. Java puro. | Solo Java estándar |
| `aplicacion` | Casos de uso (`ServicioReservas`) y puertos de entrada y de salida | `dominio` y Java estándar |
| `adaptadores` | Controlador REST y repositorios | `aplicacion`, `dominio` y su tecnología |
| `configuracion` | Raíz de composición: conecta los casos de uso con los adaptadores | Todas las capas |

Las reglas se verifican en cada build con pruebas de ArchUnit (`ArquitecturaTest`).

## Alternativas consideradas

- **Arquitectura en capas (controlador, servicio, repositorio).** Más simple y conocida por el equipo, pero el
  servicio suele terminar dependiendo de la tecnología de persistencia y las reglas quedan mezcladas con ella.
- **Sin separación (todo en el controlador).** Menos clases, pero impide probar las reglas sin levantar Spring
  y obliga a reescribir el servicio al cambiar de base de datos.

## Consecuencias

- Las reglas de negocio se prueban con pruebas unitarias rápidas y sin Spring.
- Cambiar de almacenamiento es escribir un adaptador nuevo y cambiar la configuración.
- Hay más clases (puertos, adaptadores, DTO y traducciones entre ellos), lo que aumenta la curva de entrada.
- La validación de cruces y el guardado no ocurren en la misma transacción: dos peticiones simultáneas podrían
  crear reservas que se cruzan. Es un riesgo aceptado y queda registrado en la sección de riesgos.
