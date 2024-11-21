class Prefecture < ApplicationRecord
  has_many :trip_prefectures
  has_many :trips, through: :trip_prefectures

  validates :name, presence: true, uniqueness: true
end
