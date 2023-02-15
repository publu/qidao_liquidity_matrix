class Price < ApplicationRecord
  validates :token_id, presence: true
  belongs_to :token # Network.find_each { |n| Network.reset_counters(n.id, :tokens) }
end
