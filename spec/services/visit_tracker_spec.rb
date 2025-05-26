require 'rails_helper'

RSpec.describe VisitTracker, type: :service do
  let(:short_url) { ShortUrl.create!(original_url: "https://example.com", short_code: "abc123") }

  let(:fake_request) do
    instance_double("ActionDispatch::Request", 
      remote_ip: "8.8.8.8", 
      user_agent: "test",
      referer: "https://referrer.com"
    )
  end

  it "registers a real visit" do
    tracker = VisitTracker.new(short_url: short_url, request: fake_request)

    expect {
      tracker.call
    }.to change(Visit, :count).by(1)

    visit = short_url.visits.last
    expect(visit.user_agent).to eq("test")
    expect(visit.referrer).to eq("https://referrer.com")
  end

  it "uses fake data if FAKE_DATA_IP_ADDRESS is 1" do
    ENV['FAKE_DATA_IP_ADDRESS'] = '1'

    tracker = VisitTracker.new(short_url: short_url, request: fake_request)
    expect {
      tracker.call
    }.to change(Visit, :count).by(1)

    ENV['FAKE_DATA_IP_ADDRESS'] = nil
  end
end
