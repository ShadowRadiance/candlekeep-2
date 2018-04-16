class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :confirmable,
         :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  # after create/update/delete ensure there is always an admin
  after_commit :ensure_admin

  scope :admins, -> { where(is_admin: true) }

  def ensure_admin
    User.first&.make_admin if User.admins.count.zero?
  end

  def make_admin
    update_attribute(:is_admin, true)
  end
end
