class User < ApplicationRecord
  # is_admin
  # time_zone

  # Include default devise modules. Others available are: :lockable, :timeoutable and :omniauthable
  devise :confirmable,
         :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  has_many :checkouts
  has_many :notification_requests

  # after create/update/delete ensure there is always an admin
  after_commit :ensure_admin

  scope :admins, -> { where(is_admin: true) }

  def ensure_admin
    User.first&.make_admin if User.admins.size.zero?
  end

  def make_admin
    update_attribute(:is_admin, true)
  end

  def notification_pending_for?(book)
    notification_requests.where(book: book).size.positive?
  end
end
