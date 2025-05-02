class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :salt, presence: true

  has_many :folders, dependent: :destroy
  has_many :logins, through: :folders
  has_many :urls, through: :logins
  has_many :login_shared_data, dependent: :destroy
end
