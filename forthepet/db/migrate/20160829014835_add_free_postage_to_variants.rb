class AddFreePostageToVariants < ActiveRecord::Migration
  def change
    add_column :variants, :free_postage, :boolean, default: false

    Variant.update_all(free_postage: false)
  end
end
