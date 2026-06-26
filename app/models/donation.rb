class Donation < ApplicationRecord
  belongs_to :campaign

  DISPLAY_PREFERENCES = %w[full_name first_name anonymous].freeze
  STATUSES = %w[pending paid].freeze

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :display_preference, inclusion: { in: DISPLAY_PREFERENCES }
  validates :status, inclusion: { in: STATUSES }
  validates :donor_name, presence: true

  def display_name
    case display_preference
    when "full_name"
      donor_name
    when "first_name"
      donor_name.split.first
    when "anonymous"
      nil
    end
  end
end
