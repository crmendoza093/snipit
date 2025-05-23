require 'rails_helper'

RSpec.describe Visit, type: :model do
  fixtures :short_urls, :visits

  it "is valid with valid attributes" do
    expect(visits(:first_visit)).to be_valid
  end

  it "belongs to a short_url" do
    visit = visits(:first_visit)
    expect(visit.short_url).to eq(short_urls(:one))
  end

  it "is invalid without ip_address" do
    visit = Visit.new(user_agent: "Test", short_url: short_urls(:one))
    expect(visit).not_to be_valid
  end
end
