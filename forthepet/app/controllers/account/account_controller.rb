class Account::AccountController < ApplicationController
  before_filter :authenticate_user!

  def index
    @breadcrumb_title = 'My Account'
    add_crumb 'Dashboard'

    @user = UserDecorator.decorate(current_user)
    @orders = OrderDecorator.decorate_collection(@user.orders.non_session_orders)

    @credits = 0
    @user.credits.each do |c|
      @credits += c.amount
    end
  end
end
