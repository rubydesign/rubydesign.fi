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
  
  desc "fix pics and suppliers"
  task :fix => :environment do
    Product.all.each do |p|
      props = YAML.load p.properties
      #Tuoteryhmä .. if not set before,, and delete both
      supplier = props["Valmistaja"]
      if supplier
        p.supplier = Supplier.find_or_create_by_name supplier
        p.save!
      end
      next if p.main_picture_file_name.blank?
      next if p.main_picture_file_size
      file = Dir["/Users/raisa/kauppa/public/spree/products/*/original/#{p.main_picture_file_name}"].first
      next unless file
      p.main_picture =  File.open file
      puts "Main " + file
      unless p.extra_picture_file_name.blank?
        file = Dir["/Users/raisa/kauppa/public/spree/products/*/original/#{p.extra_picture_file_name}"].first
        if file
          p.extra_picture =  File.open file
          puts "Extra " + file
        end
      end
      #line prices that have gone askew in time
      if p.line?
        prices = p.products.collect{|u| u.price }
        if(p.price < prices.min) or (p.price > prices.max)
          p.price = prices.min 
        end
      end
      #prices rounded  to 5 cent 
      if p.price 
        p.price = (((p.price % 1.0)/5.0).round(2)*5 + (p.price - p.price % 1.0)).round(2)
      else
        p.price = 0.0
      end
      p.save!
    end
  end
end