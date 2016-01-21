class SupplierMailer < ActionMailer::Base
  default from: 'support@forthepet.com.au'

  def new_order(order_item)
    @deal = order_item.deal
    @quantity_sold = order_item.quantity
    @supplier = supplier_email
    mail(to: @supplier.email, subject: 'Your For the Pet Order')
  end

  private

  def supplier_email
    if Rails.env.development?
      Supplier.new(id: 1, name: 'Grape', email: 'support@forthepet.com.au')
    else
      # Supplier.new(id: 1, name: '', email: 'support@forthepet.com.au')
      # deal.supplier.email
      nil
    end
  end
end
