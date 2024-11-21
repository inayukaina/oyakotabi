class Trip < ApplicationRecord
  has_many :trip_prefectures
  has_many :prefectures, through: :trip_prefectures
end
