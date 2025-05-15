class Sshkey < ApplicationRecord
  belongs_to :user
  validates :name, :private_key, :public_key, :iv, presence: true
end
