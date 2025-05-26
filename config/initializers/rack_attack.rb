class Rack::Attack
  # Limitar a 5 solicitudes por minuto por IP
  throttle("req/ip", limit: 5, period: 1.minute) do |req|
    if req.post? && req.path == "/urls"
      req.ip
    end
  end

  # Respuesta personalizada cuando se excede el límite
  self.throttled_response = lambda do |env|
    now = Time.now.utc
    retry_after = (env["rack.attack.match_data"] || {})[:period]
    [
      429,
      { "Content-Type" => "application/json", "Retry-After" => retry_after.to_s },
      [ { error: "Rate limit exceeded. Retry later." }.to_json ]
    ]
  end
end
