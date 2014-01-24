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
  task :fix_orders => :environment do
    Order.all.each do |order|
      puts "order #{order.number}"
      del = false
      del = true if order.created_at.year < 2012
      order.basket.items.each do |item|
        if item.product
          item.price *= (100.0 + item.product.tax ) / 100.0
          item.tax = item.product.tax
          item.tax = 24.0 if item.tax < 0.1
        else
          del = true
        end
        del ? item.delete :  item.save! 
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

  desc "fix pics"
  task :fix_pictures => :environment do
    Product.all.each do |p|
      next if p.main_picture_file_name.blank?
      next if p.main_picture_file_size
      file = Dir["/Users/raisa/kauppa/public/spree/products/*/original/#{p.main_picture_file_name}"].first
      next unless file
      f1 = File.open file
      f2 = nil
      p.main_picture =  f1
      puts "Main " + file
      unless p.extra_picture_file_name.blank?
        file = Dir["/Users/raisa/kauppa/public/spree/products/*/original/#{p.extra_picture_file_name}"].first
        if file
          f2 =  File.open file
          p.extra_picture = f2
          puts "Extra " + file
        end
      end
      p.save!
      f1.close
      f2.close if f2
    end
  end
  desc "fix pics and suppliers"
  task :fix_products => :environment do
    Product.all.each do |p|
      puts p.full_name
      if p.ean.blank?
        p.ean = p.scode
        p.scode = ""
      end
      p.scode = "" if p.ean == p.scode
      props = p.properties
      #Tuoteryhmä .. if not set before,, and delete both
      supplier = props["Valmistaja"]
      unless supplier.blank?
        p.supplier = Supplier.find_or_create_by_supplier_name supplier
      end
      group = props["Tuoteryhmä"]
      if !p.category and !group.blank?
        p.category = Category.find_or_create_by_name group
      end
      p.properties = ""
      #line prices that have gone askew in time
      if p.line?
        prices = p.products.collect{|u| u.price }
        if(p.price < prices.min) or (p.price > prices.max)
          p.price = prices.min 
        end
        p.inventory = p.products.sum(&:inventory)
      end
      #prices rounded  to 5 cent (in finland that is the smallest coin)
      if p.price 
        p.price = ((p.price / 5.0).round(2)*5.0).round(2)
      else
        p.price = 0.0
      end
      p.save!
    end
  end
end