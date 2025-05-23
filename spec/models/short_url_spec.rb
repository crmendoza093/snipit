require 'rails_helper'

RSpec.describe ShortUrl, type: :model do
  fixtures :short_urls, :visits

  it "is valid with valid attributes" do
    expect(short_urls(:one)).to be_valid
  end

  it "is invalid without original_url" do
    url = ShortUrl.new(short_code: "abc123")
    expect(url).not_to be_valid
  end

  it "is invalid without short_code" do
    url = ShortUrl.new(original_url: "https://example.com")
    expect(url).not_to be_valid
  end

  it "has many visits" do
    expect(short_urls(:one).visits.count).to eq(1)
  end
end
