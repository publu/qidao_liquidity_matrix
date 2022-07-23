class Network < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :tokens
end
