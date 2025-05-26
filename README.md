# Snipit

Clon de TinyURL construido con Ruby on Rails. Su objetivo es acortar URLs y rastrear visitas de manera simple y segura.

## Características

- Acortamiento de URLs usando tokens únicos.
- Redirección instantánea a la URL original.
- Visualización de información y métricas de cada URL acortada.
- Registro de visitas con tracking de IPs.
- Interfaz minimalista y fácil de usar.

## Arquitectura

Snipit sigue principios de diseño limpio y modular:

- **Service Objects** para encapsular la lógica de negocio como generación de tokens y persistencia.
- **Validadores personalizados** para garantizar la seguridad de las URLs procesadas.
- **Rails 8 + PostgreSQL** como base tecnológica sólida y moderna.
- **Patrón MVC** con separación clara de responsabilidades.

## Rutas principales 

- `/` - Página principal donde los usuarios ingresan URLs para acortar
- `/:short_url` - General la url corta
- `/:short_url/stats` - Muestra estadísticas de la URL acortada (visitas, ubicaciones, etc.)

## Estructura del Proyecto

```
app/
├── controllers/        # Manejo de rutas HTTP
├── models/             # Modelos de datos
├── services/           # Lógica de dominio
└── views/              # Plantillas de interfaz
```

## Configuración y desarrollo

### Requisitos previos

- Ruby 3.4.2
- Rails 8.0.2
- PostgreSQL

### Instalación

```bash
# Clonar el repositorio
git clone git@github.com:crmendoza093/snipit.git
cd snipit

# Instalar dependencias
bundle install

# Configurar la base de datos
rails db:create
rails db:migrate

# Iniciar el servidor
rails server
```

## Ejecutar test

```bash
bundle exec rspec
```

### Estructura de la base de datos

## Uso

1. Visita http://localhost:3000
2. Ingresa la URL que deseas acortar en el campo correspondiente
3. Copia el enlace acortado generado y compártelo
4. Para ver estadísticas de uso, añade `/stats` al final de la URL acortada
