workspace "Reservas de salas de estudio" "Arquitectura del servicio de reservas de la biblioteca (taller DYAS-ArquitecturaHexagonal)." {

    # Los identificadores de los elementos internos se escriben con su ruta completa,
    # por ejemplo reservas.api o reservas.api.controlador.
    !identifiers hierarchical

    model {
        estudiante = person "Estudiante" "Reserva salas de estudio de la biblioteca."
        correo = softwareSystem "Correo institucional" "Entrega los avisos al responsable de la reserva." {
            tags "Externo"
        }

        reservas = softwareSystem "Sistema de reservas de salas" "Permite reservar, consultar y cancelar salas de estudio respetando las reglas de la biblioteca." {
            # TODO (Paso 2): declare los contenedores del sistema (la API y la base de datos)
            # con su descripción y su tecnología. Ejemplo de sintaxis:
            #   api = container "Nombre" "Descripción" "Tecnología" { ... }
            #
            # TODO (Paso 3): dentro del contenedor de la API, declare los componentes del hexágono,
            # agrupados con group "Adaptadores de entrada" { ... }, group "Aplicación" { ... }, etc.
        }

        estudiante -> reservas "Reserva y cancela salas"
        reservas -> correo "Envía avisos de reserva" "SMTP"

        # TODO (Pasos 2 y 3): relaciones entre personas, contenedores y componentes, con su tecnología.

        # TODO (Paso 5): entorno de despliegue "Local" con Docker Compose:
        #   local = deploymentEnvironment "Local" { deploymentNode ... { containerInstance ... } }
    }

    views {
        # Ejemplo resuelto: diagrama de contexto (nivel 1 del modelo C4).
        systemContext reservas "Contexto" "Quién usa el sistema y con qué sistemas externos se comunica." {
            include *
            autolayout lr
        }

        # TODO (Paso 2): vista de contenedores "Contenedores".
        # TODO (Paso 3): vista de componentes "Componentes" del contenedor de la API.
        # TODO (Paso 4): vista dinámica "CrearReserva" con el flujo de POST /api/reservas.
        # TODO (Paso 5): vista de despliegue "Despliegue" del entorno Local.

        styles {
            element "Person" {
                shape person
            }
            element "Externo" {
                background #999999
                color #ffffff
            }
            element "Base de datos" {
                shape cylinder
            }
        }
    }
}
