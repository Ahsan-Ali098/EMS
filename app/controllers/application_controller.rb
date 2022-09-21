# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def current_cart
    @current_cart = Cart.find_or_create_by(user_id: current_user.id)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:user_name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.permit :sign_in, keys: %i[login password]
  end

  def after_sign_in_path_for(_resource)
    current_user.admin? ? admin_users_path : user_products_path
  end
end
