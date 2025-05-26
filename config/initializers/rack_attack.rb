class Rack::Attack
  # Limitar a 5 solicitudes por minuto por IP
  throttle("req/ip", limit: 5, period: 1.minute) do |req|
    if req.post? && req.path == "/urls"
      req.ip
    end
  end

  # Respuesta personalizada cuando se excede el límite
  Rack::Attack.throttled_responder = lambda do |request|
    match_data = request.env['rack.attack.match_data']
    now = match_data[:epoch_time]
  
    headers = {
      'RateLimit-Limit' => match_data[:limit].to_s,
      'RateLimit-Remaining' => '0',
      'RateLimit-Reset' => (now + (match_data[:period] - now % match_data[:period])).to_s
    }
  
    [ 429, headers, ["Rate limit exceeded. Retry later."]]
  end
end
