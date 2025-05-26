class ShortUrl < ApplicationRecord
  has_many :visits, dependent: :destroy

  validates :original_url, presence: true
  validates :short_code, presence: true, uniqueness: true

  def host
    @host = "http://#{ENV['HOST']}/#{short_code}"
  end
end
