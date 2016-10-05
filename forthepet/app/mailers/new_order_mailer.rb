class NewOrderMailer < ApplicationMailer
  default from: 'orders@forthepet.com.au'

  def new_order
    mail(to: 'warehouse@petshopboyz.com.au', subject: 'New Order on For The Pet')
  end
end
