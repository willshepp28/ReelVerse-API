class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if user.save
      render json: { user: user }, status: :created
    else
      render json: { errors: user.errors.full_message }, status: :unprocessable_entity
    end
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
