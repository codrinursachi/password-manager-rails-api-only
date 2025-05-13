class Note < ApplicationRecord
  belongs_to :user

  validates :text, :iv, presence: true
end
