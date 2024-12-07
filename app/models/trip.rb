class Trip < ApplicationRecord
  has_many :trip_prefectures, dependent: :destroy
  has_many :prefectures, through: :trip_prefectures
  has_many :child_packing_items, dependent: :destroy
  has_one_attached :image

  validates :budget_total, numericality: { greater_than_or_equal_to: 0 }
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_after_start_date
  validates :prefectures, length: { minimum: 1, message: "は最低1つ選択してください。" }
  validate :prefectures_must_be_unique

  private

  def end_date_after_start_date
    if end_date.present? && start_date.present? && end_date < start_date
      errors.add(:end_date, "は旅行開始日以降の日付を入力してください。")
    end
  end

  def prefectures_must_be_unique
    if prefectures.map(&:id).uniq.length != prefectures.length
      errors.add(:prefectures, "は重複して選択できません。")
    end
  end
end
