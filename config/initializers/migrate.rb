# poor mans migration. 
# Trying to keep the schema clean until version 1

if ActiveRecord::Base.connection.table_exists? :orders
  #order paid_amount
  # order all times to datetime
  #product position 
  unless Order.columns_hash["note"]
    ActiveRecord::Base.connection.add_column :orders, :note, :string , :default => ""
  end
end
if ActiveRecord::Base.connection.table_exists? :purchases
  #purchase should have email
  Purchase.where(:name => nil).each do |p|
    p.update_attribute(:name , "Sisäänosto #{I18n.l(Date.today)}")
  end
end