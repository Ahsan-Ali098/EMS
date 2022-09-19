# frozen_string_literal: true

# Registration Controller
class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  def create
    super
    if @user.save
      @cart = Cart.new(user_id: @user.id)
      @cart.save
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:user_name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.permit :sign_in, keys: %i[login password]
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
