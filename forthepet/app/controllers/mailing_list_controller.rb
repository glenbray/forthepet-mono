class MailingListController < ApplicationController
  def index
  end

  def create
    email = params[:subscribe][:email]
    subscription = SubscribeUser.new(email)

    if subscription.delay.subscribe
      flash[:success] = "Your email #{email} has now been subscribed!"
      redirect_to mailing_list_index_path
    else
      flash[:danger] = subscription.message
      redirect_to(mailing_list_index_path) && return
    end
  end
end
