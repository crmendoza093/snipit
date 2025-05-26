Geocoder.configure(
  timeout: 5,                  # Tiempo de espera para geocoder (en segundos)
  lookup: :ipinfo_io,          # Servicio de geocodificación
  ip_lookup: :ipinfo_io,       # Servicio para búsqueda de IP
  language: :es,               # Idioma preferido para los resultados
  use_https: true,             # Usar HTTPS para las solicitudes

  # Manejo de errores
  always_raise: [
    Geocoder::OverQueryLimitError,
    Geocoder::RequestDenied,
    Geocoder::InvalidRequest,
    Geocoder::InvalidApiKey
  ],
)
