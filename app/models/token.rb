class Token < ApplicationRecord
  validates :network_id, presence: true
  belongs_to :network

  GRADES_ORDERED = ["A+", "A", "A-", "B+", "B", "B-", "C+", "C", "C-", "D+", "D", "D-"]
  scope :order_by_grade, -> { order(Arel.sql(order_by_case)) }

  def self.order_by_case
    ret = "CASE"
    GRADES_ORDERED.each_with_index do |p, i|
      ret << " WHEN grade = '#{p}' THEN #{i}"
    end
      ret << " END"
  end

end
