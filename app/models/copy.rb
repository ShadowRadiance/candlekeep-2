class Copy < ApplicationRecord
  # destroyed_at
  belongs_to :book

  has_many :checkouts, -> { where(checked_in_at: nil) }

  scope :available, -> { includes(:checkouts).where(checkouts: {id: nil}) }

  def available?
    checkouts.count.zero?
  end

  def location
    if available?
      'in library'
    else
      'checked out'
    end
  end

  def current_borrower
    checkouts.first&.user
  end
end
