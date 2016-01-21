unless User.find_by_email('glen.bray@gmail.com')
  user = User.new(email: 'glen.bray@gmail.com', first_name: 'Glen', last_name: 'Bray', password: 'password', password_confirmation: 'password')
  user.billing_id = 1
  user.shipping_id = 2
  user.skip_confirmation!
  user.save!
end

unless User.find_by_email('adrianrb93@gmail.com')
  user = User.new(email: 'adrianrb93@gmail.com', first_name: 'Adrian', last_name: 'Brown', password: 'password', password_confirmation: 'password')
  user.skip_confirmation!
  user.save!
end
