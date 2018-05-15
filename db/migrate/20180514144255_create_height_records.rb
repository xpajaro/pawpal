class CreateHeightRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :height_records do |t|
      t.integer :value
      t.integer :noOfCatFans
      t.integer :noOfDogFans

      t.timestamps
    end
  end
end
