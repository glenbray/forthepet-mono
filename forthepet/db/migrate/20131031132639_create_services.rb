class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :location

      t.timestamps
    end
  end
end
