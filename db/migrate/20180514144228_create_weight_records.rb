class CreateWeightRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :weight_records do |t|
      t.integer :value
      t.integer :noOfCatFans
      t.integer :noOfDogFans

      t.timestamps
    end
  end
end
