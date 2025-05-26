class ShortUrlCreator
  def initialize(original_url:)
    @original_url = original_url
  end

  def call
    short_url = ShortUrl.find_or_initialize_by(original_url: @original_url)

    if short_url.new_record?
      short_url.short_code = generate_unique_code
      short_url.save
    end

    short_url
  end

  private

  def generate_unique_code
    loop do
      code = SecureRandom.alphanumeric(7)
      break code unless ShortUrl.exists?(short_code: code)
    end
  end
end
