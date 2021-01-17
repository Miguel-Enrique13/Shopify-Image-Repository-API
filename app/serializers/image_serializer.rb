class ImageSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :title, :description, :price, :privacy, :inventory

  belongs_to :user
end
