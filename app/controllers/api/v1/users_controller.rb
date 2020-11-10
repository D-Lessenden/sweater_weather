class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user_params[:password].nil?
      render json: {error: "Password is a required field"}, status: :not_acceptable
    elsif user_params[:password_confirmation].nil?
      render json: {error: "Password confirmation is a required field"}, status: :not_acceptable
    elsif user_params[:email].nil?
      render json: {error: "Email is a required field"}, status: :not_acceptable
    elsif user_params[:password] != user_params[:password_confirmation]
      render json: {error: "Passwords do not match"}, status: :not_acceptable
    else
    user.save
    render json: UsersSerializer.new(user)
    end
  end

  private
  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
params[:email]
