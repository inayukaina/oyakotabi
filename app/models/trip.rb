class Trip < ApplicationRecord
  has_many :trip_prefectures, dependent: :destroy
  has_many :prefectures, through: :trip_prefectures

  validates :budget_total, numericality: { greater_than_or_equal_to: 0 }
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_after_start_date
  validates :prefectures, length: { minimum: 1, message: "は最低1つ選択してください。" }

  private

  def end_date_after_start_date
    if end_date.present? && start_date.present? && end_date < start_date
      errors.add(:end_date, "は開始日以降の日付を入力してください。")
    end
  end
end
