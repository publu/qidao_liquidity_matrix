class Stable < ApplicationRecord
  has_many :stableprices, dependent: :destroy

end
