class Book < ApplicationRecord
  # title
  # author
  # genre
  # subgenre
  # pages
  # publisher

  default_scope { order(author: :asc) }

  has_many :copies, -> { where(destroyed_at: nil) }
  has_many :branches, through: :copies

  def destroyed_copies
    copies.unscoped.where.not(destroyed_at: nil)
  end

  def available_copies
    copies.available
  end

  def available_copies_at(branch)
    available_copies.where(branch: branch)
  end

  def copies_at(branch)
    copies.where(branch: branch)
  end

  def destroyed_copies_at(branch)
    destroyed_copies.where(branch: branch)
  end

  validates_presence_of :title
  validates_uniqueness_of :title, scope: [:author, :publisher]

  validates_length_of :genre, minimum: 3
  validates_length_of :author, minimum: 3, allow_blank: true, allow_nil: true
  validates_length_of :publisher, minimum: 3, allow_blank: true, allow_nil: true

  validates_presence_of :pages
  validates_numericality_of :pages, only_integer: true, greater_than: 0

end
