namespace :db do
  desc "Load seed fixtures (from db/fixtures) into the current environment's database." 
  task :import => :environment do
    from = "./../kauppa/"
    require 'active_record/fixtures'
    Dir.glob( "#{from}/*.yml").each do |file|
      ActiveRecord::Fixtures.create_fixtures("#{from}", File.basename(file, '.*'))
    end
    puts Product.count
  end

  desc "Fix datestamps that were not done in conversion from spree (harmless but messes up reports)" 
  task :fix_dates => :environment do
    updates = Order.all + Basket.all + Purchase.all
    puts "Updates #{updates.length}"
    updates.each do |update|
      next if (update.created_at - update.updated_at ).abs > 1000000
      update.update_column( :updated_at , update.created_at + 1.hour)
      print "#{update.id} "
    end
    items = Item.all
    puts "Items: #{items.length}"
    items.each do |i|
      print "#{i.id} "
      if i.basket
        i.update_column( :updated_at , i.basket.updated_at)
        i.update_column( :created_at , i.basket.created_at)
      else
        i.delete
      end
    end
  end
end