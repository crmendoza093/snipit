require 'rails_helper'

RSpec.describe "Redirections", type: :request do
  describe "GET /:short_code" do
    let!(:short_url) { ShortUrl.create!(original_url: "https://example.com", short_code: "abc123") }

    it "redirects to the original URL if it exists" do
      get "/#{short_url.short_code}", headers: {
        "REMOTE_ADDR" => "8.8.8.8",
        "HTTP_USER_AGENT" => "RSpec Test Agent",
        "HTTP_REFERER" => "http://test.local"
      }

      expect(response).to redirect_to(short_url.original_url)
    end

    it "registers a visit using VisitTracker" do
      expect {
        get "/#{short_url.short_code}", headers: {
          "REMOTE_ADDR" => "8.8.8.8",
          "HTTP_USER_AGENT" => "RSpec Test Agent",
          "HTTP_REFERER" => "http://test.local"
        }
      }.to change(Visit, :count).by(1)
    end

    it "shows 404 if the code does not exist" do
      get "/noexiste123"
      expect(response).to have_http_status(:not_found)
    end
  end
end
