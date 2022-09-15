# frozen_string_literal: true

# class InvitationsController
class InvitationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.user_name = @user.user_name.to_s
    @password = @user.password
    InviteMailer.send_invitation(@user, @password).deliver_later if @user.save
    redirect_to admin_users_path
  end

  private

  def find_user
    @user = (User.find(params[:id]) if params[:id].present?)
  end

  def user_params
    params.require(:user).permit(:email, :password, :user_name)
  end
end
