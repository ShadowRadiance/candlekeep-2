class Book < ApplicationRecord
  # title
  # author
  # genre
  # subgenre
  # pages
  # publisher

  default_scope { order(author: :asc) }

  has_many :copies, -> { where(destroyed_at: nil) }
  def destroyed_copies
    Copy.where.not(destroyed_at: nil).where(book: self)
  end

  validates_presence_of :title
  validates_uniqueness_of :title, scope: [:author, :publisher]

  validates_length_of :genre, minimum: 3
  validates_length_of :author, minimum: 3, allow_blank: true, allow_nil: true
  validates_length_of :publisher, minimum: 3, allow_blank: true, allow_nil: true

  validates_presence_of :pages
  validates_numericality_of :pages, only_integer: true, greater_than: 0

end
