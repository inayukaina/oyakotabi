class TripPrefecture < ApplicationRecord
  belongs_to :trip
  belongs_to :prefecture

  validates :trip_id, presence: true
  validates :prefecture_id, presence: true
end
