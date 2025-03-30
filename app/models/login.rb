class Login < ApplicationRecord
  belongs_to :folder
  has_many :urls, dependent: :destroy
  has_many :custom_fields, dependent: :destroy
  has_many :shared_login_data, dependent: :destroy
  has_one_attached :file

  validates :name, :login_name, :login_password, presence: true

  accepts_nested_attributes_for :urls, reject_if: :all_blank
  accepts_nested_attributes_for :custom_fields, reject_if: :all_blank
end
