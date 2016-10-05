# Preview all emails at http://localhost:3000/rails/mailers/new_order_mailer
class NewOrderMailerPreview < ActionMailer::Preview
  def new_order
    NewOrderMailer.new_order
  end
end
