class Api::V1::ImagesController < ApplicationController
  def one_image
    render json: ImageSerializer.new(Image.create!(image_params, user_id: @current_user.id))
  end

  def bulk_images
    params[:image_files].each do |image_file|
      Image.create!(image_file: image_file, user_id: @current_user.id)
    end

    size = params[:image_files].size

    render json: ImageSerializer.new(Image.last(size))
  end

  private

  def image_params
    params.permit(:id, :title, :description, :price, :inventory, :privacy, :image_file)
  end
end
