class ShortUrlCreator
  def initialize(original_url:)
    @original_url = original_url
  end

  def call
    ShortUrl.find_or_create_by(original_url: @original_url) do |short_url|
      short_url.short_code = generate_unique_code
    end
  end

  private

  def generate_unique_code
    loop do
      code = SecureRandom.alphanumeric(7)
      break code unless ShortUrl.exists?(short_code: code)
    end
  end
end
