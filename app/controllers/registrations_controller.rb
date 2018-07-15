# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  def create
    super
  end

  def destroy
    events = Event.where(owner_id: current_user.id)
    events.each(&:destroy!)
    super
  end

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :twitter)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :twitter)
  end
end
