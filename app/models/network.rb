class Network < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :chain_id, presence: true, uniqueness: true
  has_many :tokens
  extend FriendlyId
  friendly_id :name, use: :slugged

  GRADES_ORDERED = ["A+", "A", "A-", "B+", "B", "B-", "C+", "C", "C-", "D+", "D", "D-"]
  scope :order_by_grade, -> { order(Arel.sql(order_by_case)) }

  def self.order_by_case
    ret = "CASE"
    GRADES_ORDERED.each_with_index do |p, i|
      ret << " WHEN network.token.grade = '#{p}' THEN #{i}"
    end
      ret << " END"
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |network|
        csv << network.attributes.values_at(*column_names)
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      network = find_by_id(["id"]) || new
      network.attributes = row.to_hash.slice(*accessible_attributes)
      network.save!
    end
  end
end
