require 'rails_helper'

RSpec.describe "ShortUrls", type: :request do
  describe "GET /urls/new" do
    it "shows the form" do
      get new_short_url_path
      expect(response).to be_successful
    end
  end

  describe "POST /urls" do
    it "creates a new short URL and redirects to the root" do
      expect {
        post short_urls_path, params: { short_url: { original_url: "https://rails.org" } }
      }.to change(ShortUrl, :count).by(1)

      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET /:short_code/stats" do
    let!(:short_url) { ShortUrl.create!(original_url: "https://rails.org", short_code: "stats123") }

    it "shows the stats if it exists" do
      get short_url_stats_path(short_url.short_code)
      expect(response).to have_http_status(:success)
    end
  end
end
