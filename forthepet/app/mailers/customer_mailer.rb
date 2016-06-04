class CustomerMailer < ActionMailer::Base
  include Roadie::Rails::Automatic

  default from: 'orders@forthepet.com.au'

  def customer_invoice(order)
    @order = order.decorate
    mail(to: @order.email, subject: 'Your For the Pet Order')
  end

  def shipping_order(order)
    @order = order.decorate
    mail(to: @order.email, subject: 'Your For the Pet Order has been Shipped!')
  end
end
