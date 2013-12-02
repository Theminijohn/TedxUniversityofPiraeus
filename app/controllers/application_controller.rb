class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  before_filter :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end



  # Your application controller will need to know what to do
  # if a CanCan exception is thrown
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  # CanCan Forbidden Attributes Workaround
  before_filter do
     resource = controller_name.singularize.to_sym
     method = "#{resource}_params"
     params[resource] &&= send(method) if respond_to?(method, true)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :password, :password_confirmation, :first_name,
               :last_name, :provider, :uid)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:email, :password, :current_password, :first_name,
               :last_name)
    end
  end


end
