unless Admin.find_by_email('glen.bray@gmail.com')
  user = Admin.new(username: 'glen', email: 'glen.bray@gmail.com', password: 'password', password_confirmation: 'password')
  user.save!
end

unless Admin.find_by_email('adrianrb93@gmail.com')
  user = Admin.new(email: 'adrianrb93@gmail.com', password: 'password', password_confirmation: 'password')
  user.save!
end
