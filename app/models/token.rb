class Token < ApplicationRecord
  validates :network_id, presence: true
  validates :minter_id, presence: true
  belongs_to :network
  belongs_to :minter

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  GRADES_ORDERED = ["A+", "A", "A-", "B+", "B", "B-", "C+", "C", "C-", "D+", "D", "D-"]
  scope :order_by_grade, -> { order(Arel.sql(order_by_case)) }

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
