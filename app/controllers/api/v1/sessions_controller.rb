class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if params[:email].nil?
      render json: {error: "Email is a require field"}, status: :not_acceptable
    elsif params[:password].nil?
      render json: {error: "Password is a require field"}, status: :not_acceptable
    elsif user && user.authenticate(params[:password])
      render json: SessionsSerializer.new(user)
    else
      render json: {error: "Incorrect credentials"}, status: :unauthorized
    end
  end
end
