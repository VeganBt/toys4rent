require "date"

class Booking < ApplicationRecord
  STATUSES = %w[accepted declined pending completed]

  belongs_to :user
  belongs_to :toy

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES }

  # This validates that the start and end dates are OK
  validate :valid_start_date?
  validate :valid_end_date?

  private

  def valid_start_date?
    if start_date < Date.today
      errors.add(:start_date, "should be today or in the future")
    end
  end

  def valid_end_date?
    if end_date < start_date
      errors.add(:end_date, "should be greater than the start date")
    end
  end
end
