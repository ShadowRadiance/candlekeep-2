class Book < ApplicationRecord
  # title
  # author
  # genre
  # subgenre
  # pages
  # publisher

  default_scope { order(author: :asc) }

  has_many :copies
  has_many :branches, through: :copies

  def undestroyed_copies
    copies.active
  end

  def destroyed_copies
    copies.inactive
  end

  def available_copies
    copies.available
  end

  def available_copies_at(branch)
    available_copies.where(branch: branch)
  end

  def copies_at(branch)
    undestroyed_copies.where(branch: branch)
  end

  def destroyed_copies_at(branch)
    destroyed_copies.where(branch: branch)
  end

  def generate_count_caches
    copies_array = copies.to_a
    active_copies_array = copies_array.select(&:active?)
    available_copies_array = active_copies_array.select(&:available?)
    @max_copy_count = active_copies_array.size
    @available_copy_count = available_copies_array.size

    av_by_branch_id = available_copies_array.group_by { |copy| copy.branch.id }
    @available_copy_count_by_branch_id = Hash.new(0)
    av_by_branch_id.each do |id, copies|
      @available_copy_count_by_branch_id[id] = copies.size
    end
  end
  def cached_available_copy_count_at(branch)
    @available_copy_count_by_branch_id[branch.id]
  end
  def cached_available_copy_count
    @available_copy_count
  end
  def cached_max_copy_count
    @max_copy_count
  end

  validates_presence_of :title
  validates_uniqueness_of :title, scope: [:author, :publisher]

  validates_length_of :genre, minimum: 3
  validates_length_of :author, minimum: 3, allow_blank: true, allow_nil: true
  validates_length_of :publisher, minimum: 3, allow_blank: true, allow_nil: true

  validates_presence_of :pages
  validates_numericality_of :pages, only_integer: true, greater_than: 0

end
