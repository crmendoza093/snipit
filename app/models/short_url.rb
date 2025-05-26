class ShortUrl < ApplicationRecord
  has_many :visits, dependent: :destroy

  validates :short_code, presence: true, uniqueness: true
  validates :original_url, presence: true, format: { 
    with: URI::DEFAULT_PARSER.make_regexp(%w[http https]),
    message: "no es una URL válida"
  }

  def host
    @host = "http://#{ENV['HOST']}/#{short_code}"
  end
end
