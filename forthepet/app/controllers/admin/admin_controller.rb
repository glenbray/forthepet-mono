class Admin::AdminController < ActionController::Base
  before_filter :authenticate_admin!
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  layout 'admin'
  add_crumb 'For the Pet', '/'
  add_crumb 'Admin Dashboard', '/admin'

  def index
    @active_count = Deal.active_deals.count
    @order_count = Order.non_session_orders.count
    @orders_total = Order.sum(:total)
  end

  def current_ability
    @ability ||= Ability.new(current_admin)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end

end
