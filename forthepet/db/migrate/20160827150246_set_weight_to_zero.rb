class SetWeightToZero < ActiveRecord::Migration
  def change
    Variant.update_all(weight: 0)
  end
end
