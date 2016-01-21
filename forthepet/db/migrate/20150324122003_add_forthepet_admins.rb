class AddForthepetAdmins < ActiveRecord::Migration
  def change

    new_admins = [
      Admin.create(email: 'DanielC@petshopboyz.com.au', username: 'danny', password: 'password', password_confirmation: 'password'),
      Admin.create(email: 'carmeljones@petshopboyz.com.au', username: 'carmel', password: 'password', password_confirmation: 'password'),
      Admin.create(email: 'Warehouse@petshopboyz.com.au ', username: 'trent', password: 'password', password_confirmation: 'password')
    ]

    new_admins.each do |admin|
      admin.roles = [Admin::ROLES[1]]
      admin.save
    end

    me = Admin.find_by_username('glen')
    me.roles = [Admin::ROLES[0]]
    me.save
  end
end
