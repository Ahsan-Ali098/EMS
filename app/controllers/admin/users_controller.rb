# frozen_string_literal: true

# User Controller
module Admin
  # Class User Controller
  class UsersController < ApplicationController
    before_action :find_user, only: %i[show update edit destroy]

    def index
      @users = User.all.page(params[:page])
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to @user
      else
        render 'new'
      end
    end

    def show
      @user = User.find(params[:id])
    end

    def update
      if @user.update(user_params)
        redirect_to([:admin, @user])
      else
        render 'edit'
      end
    end

    def edit; end

    def destroy
      @user.destroy
      redirect_to admin_user_path
    end

    private

    def find_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:user_name, :email, :password)
    end
  end
end
