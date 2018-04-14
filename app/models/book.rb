class Book < ApplicationRecord
  # title
  # author
  # genre
  # subgenre
  # pages
  # publisher
  has_many :copies
end
