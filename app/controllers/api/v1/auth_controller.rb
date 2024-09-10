class Api::V1::AuthController < ApplicationController

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = encode_token({ user_id: user.id })
      render json: { user: user, token: token }, status: :ok
    else
      render json: { error: 'Invalid email or password'}, status: :unauthorized
    end
  end

  def encode_token(payload)
    JWT.encode(payload, ENV['JWT_SECRET_KEY'])
  end
end
