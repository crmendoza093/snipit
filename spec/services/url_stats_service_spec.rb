require 'rails_helper'

RSpec.describe UrlStatsService, type: :service do
  fixtures :short_urls
  let(:short_url) { short_urls(:one) }  

  it "retorna estadísticas básicas y por país" do
    service = UrlStatsService.new(short_url)
    result = service.call

    expect(result[:total_visits]).to eq(2)
    expect(result[:visits]).to be_an(ActiveRecord::Relation)
    expect(result[:top_country]).to eq("Colombia")
    expect(result[:country_stats].first).to eq(["Colombia", 2])
  end
end
