class Minter < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :tokens
  extend FriendlyId
  friendly_id :name, use: :slugged
end
