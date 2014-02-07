# poor mans migration. 
# Trying to keep the schema clean until version 1

unless Basket.columns_hash["locked"]
  ActiveRecord::Base.connection.add_column :baskets, :locked, :date
end