require 'rails_helper'

RSpec.describe ShortUrlCreator do
  describe "#call" do
    fixtures :short_urls

    let(:original_url) { short_urls(:one).original_url }

    it "creates a new short URL if it doesn't exist" do
      creator = described_class.new(original_url: original_url)
      result = creator.call

      expect(result).to be_persisted
      expect(result.original_url).to eq(original_url)
    end

    it "returns the same short URL if it already exists" do
      existing = ShortUrl.find_by(original_url: original_url)

      creator = described_class.new(original_url: original_url)
      result = creator.call

      expect(result).to eq(existing)
    end
  end
end
