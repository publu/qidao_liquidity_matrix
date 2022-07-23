class Token < ApplicationRecord
  validates :network_id, presence: true
  belongs_to :network

  def self.search(params)
    params[:query].blank? ? all : where(
      "network_id LIKE ?", "#{sanitize_sql_like(params[:query])}"
    )
  end
end
