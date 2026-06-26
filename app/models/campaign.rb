class Campaign < ApplicationRecord
  has_many :donations, dependent: :destroy

  validates :title, presence: true
  validates :goal_amount, presence: true, numericality: { greater_than: 0 }

  def amount_raised
    donations.sum(:amount)
  end

  def donors_count
    donations.count
  end

  def progress_percentage
    return 0 if goal_amount.zero?
    ((amount_raised / goal_amount) * 100).round
  end
end
