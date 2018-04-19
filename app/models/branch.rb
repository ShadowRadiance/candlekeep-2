class Branch < ApplicationRecord

  has_many :copies
  has_many :books, through: :copies

  validates_presence_of :name

  def carries_copy_of?(book)
    copies_of(book).count.positive?
  end

  def carries_available_copy_of?(book)
    available_copies_of(book).count.positive?
  end

  def copies_of(book)
    book.copies_at(self)
  end

  def available_copies_of(book)
    copies_of(book).available
  end

end
