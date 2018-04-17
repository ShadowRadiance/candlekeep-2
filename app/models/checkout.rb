class Checkout < ApplicationRecord
  # checked_out_at
  # due_at
  # checked_in_at

  belongs_to :copy
  belongs_to :user

  scope :active, -> { where(checked_in_at: nil) }
  scope :overdue, -> { active.where('...') }

  def overdue
    user_zone = user.time_zone

    user_due_at = due_at.in_time_zone(user_zone)
    user_current = Time.current.in_time_zone(user_zone)

    user_due_at > user_current
  end

end
