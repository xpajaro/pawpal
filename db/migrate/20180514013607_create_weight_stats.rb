class CreateWeightStats < ActiveRecord::Migration[5.1]
  def change
    create_table :weight_stats do |t|
      t.integer :weight
      t.integer :noOfDogFans
      t.integer :noOfCatFans

      t.timestamps
    end
  end
end
