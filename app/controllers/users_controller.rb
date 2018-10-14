# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    redirect_to root_path unless current_user.admin?
    @users = User.all
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :twitter, :preffered_name)
  end
end
