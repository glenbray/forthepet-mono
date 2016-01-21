class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.integer 'amount'
      t.belongs_to 'user'
      t.timestamps
    end
  end
end
