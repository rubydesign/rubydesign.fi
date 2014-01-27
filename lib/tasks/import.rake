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

end