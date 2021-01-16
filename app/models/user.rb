class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true, case_sensitive: false
  validates :password, presence: true, confirmation: true, allow_nil: true

  has_many :images

  has_secure_password
end
