class Token < ApplicationRecord
  validates :network_id, presence: true
  validates :minter_id, presence: true
  belongs_to :network, counter_cache: true # Network.find_each { |n| Network.reset_counters(n.id, :tokens) }
  belongs_to :minter
  has_many :prices, dependent: :destroy

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  GRADES_ORDERED = ["A+", "A", "A-", "B+", "B", "B-", "C+", "C", "C-", "D+", "D", "D-"]
  scope :order_by_grade, -> { order(Arel.sql(order_by_case)) }

  scope :order_by_debt, -> { order(mai_debt: :desc) }
  scope :order_by_liquidity, -> { order(liquidity: :desc) }
  scope :order_by_volatility, -> { order(risk_volatility: :asc) }

  def self.order_by_case
    ret = "CASE"
    GRADES_ORDERED.each_with_index do |p, i|
      ret << " WHEN grade = '#{p}' THEN #{i}"
    end
      ret << " END"
  end

  def network_name
    self.network.name
  end

  def slug_candidates
	   [ "#{symbol}-#{network_name}" ]
	end

  def should_generate_new_friendly_id?
    slug.blank? && symbol_changed? && network_id_changed?
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |token|
        csv << token.attributes.values_at(*column_names)
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      token = find_by_id(["id"]) || new
      token.attributes = row.to_hash.slice(*accessible_attributes)
      token.save!
    end
  end


end
