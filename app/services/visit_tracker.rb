class VisitTracker
  def initialize(short_url:, request:)
    @short_url = short_url

    build_data(request)
  end

  def call
    country = lookup_country(@ip_address)

    @short_url.visits.create!(
      ip_address: @ip_address,
      user_agent: @user_agent,
      referrer: @referrer,
      country: country
    )
  end

  private

  def lookup_country(ip)
    return "Local" if ip.blank? || [ "127.0.0.1", "::1" ].include?(ip)

    location = Geocoder.search(ip).first
    location&.country || "Desconocido"
  end

  # Builds the data for the visit
  # If the environment variable FAKE_DATA_IP_ADDRESS is set to 1, the data will be fake
  # Otherwise, the data will be the real data from the request
  def build_data(request)
    if ENV["FAKE_DATA_IP_ADDRESS"] == "1"
      @ip_address = Faker::Internet.public_ip_v4_address
      @user_agent = Faker::Internet.user_agent
      @referrer = Faker::Internet.url
    else
      @ip_address = request.remote_ip || "0.0.0.0"
      @user_agent = request.user_agent
      @referrer = request.referer
    end
  end
end
