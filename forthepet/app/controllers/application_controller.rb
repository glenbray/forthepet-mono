class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :session_referral_id
  before_filter :configure_permitted_parameters, if: :devise_controller?

  helper_method :session_referral_id
  helper_method :session_cart

  add_crumb '<i class="fa fa-home"></i>Home'.html_safe, '/'

  def after_sign_in_path_for(resource)
    if resource.class == User
      referral_id = session[:referral_id] || resource.referral_id
      user = User.find_by_referral_id(referral_id)

      if user
        referral = user.referrals.build(email: resource.email)
        referral.save
        resource.referred_by = user.email
        resource.save
      end

      request.env['omniauth.origin'] || stored_location_for(resource) || root_path
    else
      admin_root_url
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation) }
  end

  private

  def session_cart
    return @session_cart if defined?(@session_cart)
    session_cart!
  end

  def session_cart!
    unless cookies[:cart_id].blank?
      @session_cart = Cart.find(cookies[:cart_id])
      cookies[:cart_id] = nil if @session_cart.nil?
    end
    @session_cart ||= Cart.new
  end

  def session_referral_id
    cookies[:rid] = { value: params[:rid], expires: 1.year.from_now } if params.key?(:rid)
    cookies[:rid]
  end
end
