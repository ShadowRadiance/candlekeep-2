class Checkout < ApplicationRecord
  # checked_out_at
  # due_at
  # checked_in_at

  belongs_to :copy
  belongs_to :user

  scope :active, -> { where(checked_in_at: nil) }
  scope :overdue, ->(at_utc) { where('due_at < ?', at_utc) }

  before_create :set_due_date


  # @param [Object] at_time_utc     The time in UTC (e.g. Time.current)
  def overdue(at_time_utc)
    user_zone = user.time_zone

    user_due_at = due_at.in_time_zone(user_zone)
    user_current = at_time_utc.in_time_zone(user_zone)

    user_due_at < user_current
  end

  private

  def set_due_date
    # book must be returned one week after checkout date
    local_checkout = checked_out_at.in_time_zone(user.time_zone)
    self.due_at = local_checkout.end_of_day + 1.week
  end

end

# Checkout.all.map do |c|
#   {
#     due_at: c.due_at,
#     due_at_local: c.due_at.in_time_zone(c.user.time_zone),
#     overdue: c.overdue(Time.current)
#   }
# end
