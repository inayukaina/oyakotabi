class Trip < ApplicationRecord
  has_many :trip_prefectures, dependent: :destroy
  has_many :prefectures, through: :trip_prefectures

  validates :budget_total, numericality: { greater_than_or_equal_to: 0 }
  

end
