class ReferralsController < ApplicationController
  def index
    @referral_url = referral_url(current_user.referral_id) if current_user
  end

  def show
    if current_user
      user = User.find_by_referral_id(params[:id])
      current_user.update(referred_by: user.email) if user && current_user.orders.zero?
    else
      session[:referral_id] = params[:id]
    end
    redirect_to root_url
  end

end

# check that referral user is not referring user!
# check if user is logged in

# At the end of an order check if the user has been referred by another user (if first time purchase)
# and apply a referral discount to the referring user.
# Discounts should have an applied column to check if discount has already been applied to a order..
