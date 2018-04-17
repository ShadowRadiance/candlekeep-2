class Copy < ApplicationRecord
  # destroyed_at
  belongs_to :book
  has_many :checkouts

  # faking the available scope for now since we don't have checkouts yet
  # but it should be something like this
  # scope :available, -> { includes(:checkouts).where(checkouts: {id: nil}) }
  scope :available, -> { limit(5) }



  def available?
    true
    # checkouts.checked_out.empty?
  end

  def location
    if Random.new.rand(0..1).zero?
      'in library'
    else
      'checked out'
    end
  end
end
