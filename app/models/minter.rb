class Minter < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :tokens, strict_loading: true
  extend FriendlyId
  friendly_id :name, use: :slugged
end
