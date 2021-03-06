class Image < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { only_float: true }
  validates :inventory, presence: true, numericality: { only_integer: true }
  validates :privacy, inclusion: { in: %w[private public] }

  has_one_attached :image_file

  belongs_to :user
end
