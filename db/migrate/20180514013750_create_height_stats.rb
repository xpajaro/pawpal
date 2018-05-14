class CreateHeightStats < ActiveRecord::Migration[5.1]
  def change
    create_table :height_stats do |t|
      t.integer :height
      t.integer :noOfDogFans
      t.integer :noOfCatFans

      t.timestamps
    end
  end
end
