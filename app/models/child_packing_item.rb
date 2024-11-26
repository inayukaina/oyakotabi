class ChildPackingItem < ApplicationRecord
  belongs_to :trip

  validates :name, presence: true
  validates :quantity, numericality: { greater_than: 0 }
end
