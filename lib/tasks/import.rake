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
    Order.all.each do |order|
      del = false
      del = true if order.created_at.year < 2012
      order.basket.items.each do |item|
        if item.product
          item.price *= (100.0 + item.product.tax ) / 100.0
        else
          del = true
        end
        item.save! unless del
      end
      if(del)
        order.basket.delete
        order.delete
      else
        order.basket.save!
        order.save!
      end
    end
  end

  desc "fix pics and suppliers"
  task :fix => :environment do
    Product.all.reverse.each do |p|
      props = p.properties
      #Tuoteryhmä .. if not set before,, and delete both
      supplier = props["Valmistaja"]
      unless supplier.blank?
        p.supplier = Supplier.find_or_create_by_supplier_name supplier
        p.save!
      end
      group = props["Tuoteryhmä"]
      if !p.category and !group.blank?
        p.category = Category.find_or_create_by_name group
        p.save!
      end
      p.properties = ""
      p.save
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
        p.inventory = p.products.sum(&:inventory)
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