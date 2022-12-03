class Stableprice < ApplicationRecord
  validates :stable_id, presence: true
  belongs_to :stable
end
