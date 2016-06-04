class AddNameSlugToProducts < ActiveRecord::Migration
  def change
    Product.find_each(&:save)
  end
end
