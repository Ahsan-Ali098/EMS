# frozen_string_literal: true

# User Controller
module Admin
  # Class User Controller
  class UsersController < ApplicationController
    before_action :find_user, only: %i[show update edit destroy]
    helper_method :sort_column, :sort_direction
    before_action :current_cart

    def index
      per_page = params[:page]
      search_param = params[:search]
      search(search_param, per_page)
      respond_to do |format|
        format.html
        format.csv { send_data ExportService::UserExport.new(User.all).to_csv, filename: "userinfo-#{Date.today}.csv" }
      end
    end

    def sort_param
      "#{sort_column} #{sort_direction}"
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

    def show; end

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
      redirect_to admin_users_path
    end

    private

    def search(search_param, per_page)
      @users = if search_param.present?
                 User.search_user(search_param)
                   .page(per_page)
               else
                 User.all.page(per_page).order(sort_param)
               end
      @users.page(per_page)
    end

    def find_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:user_name, :email, :password)
    end

    def sort_column
      User.column_names.include?(params[:sort]) ? params[:sort] : 'id'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end
  end
end
