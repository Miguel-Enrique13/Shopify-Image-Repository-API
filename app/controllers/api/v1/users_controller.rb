class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_request
  def create
    user = User.new(user_params)
    if user.save
      render json: { message: 'User created successfully' }, status: :ok
    else
      render json: { message: user.errors.full_messages.to_sentence }
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
