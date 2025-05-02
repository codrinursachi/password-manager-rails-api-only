class Rsa < ApplicationRecord
  belongs_to :user

  validates :public_key, presence: true
  validates :private_key, presence: true
  validates :private_key_iv, presence: true
end
