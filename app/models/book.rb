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

  validates_presence_of :title, :genre, :pages
  validates_length_of :author, :genre, minimum: 3
  validates_length_of :author, :publisher, minimum: 3, allow_blank: true
  validates_numericality_of :pages, only_integer: true, greater_than: 0
  validates_uniqueness_of :title, scope: :author
end
