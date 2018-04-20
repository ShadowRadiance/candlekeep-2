class Copy < ApplicationRecord
  # destroyed_at
  belongs_to :book
  belongs_to :branch
  belongs_to :checked_out_by, class_name: 'User', optional: true

  scope :available, -> { where.not(checked_out_by: nil) }

  before_validation :set_due_date

  def available?
    checked_out_by.nil?
  end

  def location
    if available?
      branch.name
    else
      'checked out'
    end
  end

  def current_borrower
    checked_out_by
  end

  private

  def set_due_date
    if checked_out_at.nil?
      self.due_at = nil
    else
      # book must be returned one week after checkout date
      local_checkout = checked_out_at.in_time_zone(checked_out_by.time_zone)
      self.due_at = local_checkout.end_of_day + 1.week
    end
  end
end
