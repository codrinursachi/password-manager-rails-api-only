class Url < ApplicationRecord
  belongs_to :login
  has_one_attached :fav_icon
end
