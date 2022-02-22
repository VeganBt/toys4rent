require "date"

class Booking < ApplicationRecord
  STATUSES = %w[accepted declined pending completed]

  belongs_to :user
  belongs_to :toy

  validates :start_date, presence: true, comparison: { greater_than_or_equal_to: Date.today }
  validates :end_date, presence: true, comparison: { greater_than_or_equal_to: :start_date }
  validates :status, presence: true, inclusion: { in: STATUSES }
end
