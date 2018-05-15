namespace :db do
  desc "Erase and fill database"
  
  task :populate => :environment do
    [WeightRecord, HeightRecord].each(&:delete_all)

    300.times do
      WeightRecord.create( value:rand(60..250), noOfCatFans:rand(0..100), noOfDogFans:rand(0..100))
      HeightRecord.create( value:rand(40..80), noOfCatFans:rand(0..100), noOfDogFans:rand(0..100))
    end

  end

end