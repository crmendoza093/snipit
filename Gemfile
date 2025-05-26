source "https://rubygems.org"

ruby "3.4.2"

# Framework principal
gem "rails", "~> 8.0.2"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "propshaft"

# Serialización
gem "active_model_serializers"

# Performance
gem "bootsnap", require: false

# Calidad de código, seguridad y estilo
group :development, :test do
  gem "brakeman", require: false       # Análisis estático de seguridad
  gem "rubocop-rails-omakase", require: false # Linter Ruby/Rails con estilo recomendado
  gem "rspec-rails"                    # Framework de testing
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "byebug"
end

# Herramientas solo para desarrollo
group :development do
  gem "web-console"       # Consola en errores
  gem "dotenv-rails"      # Variables de entorno desde `.env`
end

# Herramientas solo para test
group :test do
  gem "faker"             # Datos falsos para pruebas
  gem "shoulda-matchers"  # Matchers para RSpec
end

gem "geocoder"
gem "faker"
gem "rack-attack"
