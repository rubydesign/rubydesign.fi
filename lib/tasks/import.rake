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
      puts file
      p.save!
    end
  end
end