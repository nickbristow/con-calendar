# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    @user.save
    redirect_to users_path
  end

  def show
    render 'new'
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :twitter, :preffered_name)
  end
end
