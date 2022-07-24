class Token < ApplicationRecord
  validates :network_id, presence: true
  belongs_to :network

end
