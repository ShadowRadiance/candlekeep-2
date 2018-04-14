class Copy < ApplicationRecord
  belongs_to :book

  # faking the available scope for now since we don't have checkouts yet
  # but it should be something like this
  # scope :available, -> { includes(:checkouts).where(checkouts: {id: nil}) }
  scope :available, -> { limit(5) }
end
