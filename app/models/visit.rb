class Visit < ApplicationRecord
  belongs_to :short_url

  validates :ip_address, presence: true
  validates :user_agent, presence: true
end
