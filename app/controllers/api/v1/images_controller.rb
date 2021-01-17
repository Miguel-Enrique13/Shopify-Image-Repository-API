class Api::V1::ImagesController < ApplicationController
  def upload_one_image
    render json: ImageSerializer.new(@current_user.images.create!(image_params))
  end

  def upload_bulk_images
    params[:image_files].each do |image_file|
      Image.create!(image_file: image_file, user_id: @current_user.id)
    end

    size = params[:image_files].size

    render json: ImageSerializer.new(Image.last(size))
  end

  def delete_one_image
    if @current_user == Image.find(params[:image_id]).user
      Image.destroy(params[:image_id])
      render json: { message: "Image deleted"}, status: 200
    else
      render json: { errors: 'Unauthorized User' }, status: :unauthorized
    end
  end

  def delete_bulk_images
    params[:image_id].each do |id|
      Image.destroy(id) if Image.find(id) && Image.find(id).user == @current_user
    end

    render json: { message: 'All authorized images have been deleted' }
  end

  private

  def image_params
    params.permit(:id, :title, :description, :price, :inventory, :privacy, :image_file)
  end
end
