class User < ApplicationRecord
  has_secure_password validations: false

  validates :email, presence: true, uniqueness: true
  validates :salt, presence: true
  validates :password, length: { minimum: 6 }, allow_blank: true

  has_many :folders, dependent: :destroy
  has_many :logins, through: :folders
  has_many :urls, through: :logins
  has_many :login_shared_data, dependent: :destroy
  has_one :rsa, dependent: :destroy

  accepts_nested_attributes_for :rsa
end
