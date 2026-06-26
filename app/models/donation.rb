class Donation < ApplicationRecord
  belongs_to :campaign

  DISPLAY_PREFERENCES = %w[show_name_and_amount show_name_only show_amount_only].freeze
  STATUSES = %w[pending paid].freeze

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :display_preference, inclusion: { in: DISPLAY_PREFERENCES }
  validates :status, inclusion: { in: STATUSES }
  validates :donor_name, presence: true

  def show_name?
    display_preference.in?(%w[show_name_and_amount show_name_only])
  end

  def show_amount?
    display_preference.in?(%w[show_name_and_amount show_amount_only])
  end
end
