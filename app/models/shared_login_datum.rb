class SharedLoginDatum < ApplicationRecord
  belongs_to :login
  belongs_to :user

  vaildate :password, presence: true

  scope :by_current_user, ->(belongs_to_current_user, user_id) { belongs_to_current_user ? joins(login: :folder).where(folders: { user_id: user_id }) : joins(login: :folder).where.not(folders: { user_id: user_id }) }
end
