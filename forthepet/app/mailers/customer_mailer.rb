class CustomerMailer < ActionMailer::Base
  include Roadie::Rails::Automatic

  default from: 'orders@forthepet.com.au'

  def customer_invoice(order)
    @order = order.decorate
    mail(to: @order.email, subject: 'Your For the Pet Order')
  end

  def shipping_order(order)
    @order = order.decorate

    @tracking_msg = "Your tracking no is #{@order.tracking_no}" if @order.tracking_no
    @tracking_msg = "#{@tracking_msg} and will be delivered by #{@order.courier}" if @order.tracking_no && @order.courier

    mail(to: @order.email, subject: 'Your For the Pet Order has been Shipped!')
  end
end
