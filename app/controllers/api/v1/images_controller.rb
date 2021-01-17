class Api::V1::ImagesController < ApplicationController
  def one_image
    binding.pry
    render json: ImageSerializer.new(Image.create!(image_params))
  end

  private

  def image_params
    params.permit(:id, :title, :description, :price, :inventory, :privacy, :image_file, :user_id )
  end
end
