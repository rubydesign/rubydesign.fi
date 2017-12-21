# encoding : utf-8
class ManageController < AdminController
  include Reporter

  def all
  end
  
  def reports
    @attributes = [ "price" , "quantity" , "id", "name" ,
                    "basket_id" , "product_id" ,
                    "baskets.kori_type" , "products.category_id",
                    "products.supplier_id" , "created_at"]
    @group_names = { "all" => "All" ,
                     "products.supplier_id" => t(:supplier) ,
                     "products.category_id" => t(:category) ,
                     "product_id" => t(:product) ,
                     "email" => t(:email) }
    @start = params[:start] ? Time.at(params[:start].to_i) : 3.months.ago.beginning_of_month
    @end =   params[:end]   ? Time.at(params[:end].to_i)   : Date.today.end_of_month
    basket_index =   @attributes.index("basket_id")
    created_index =  @attributes.index("created_at")
    price_index =    @attributes.index("price")
    quantity_index = @attributes.index("quantity")
    emails = Basket.unscoped.where("baskets.created_at": @start..@end).
                  includes(:order).where.not(locked: nil).
                  pluck("baskets.id" , "orders.email", "orders.address").
                  collect do |basket,email,address|
                    if address.blank?
                      [basket, email]
                    else
                      name = address.split("\n")[1]
                      name ? [basket, name.sub("name: ","")] : [basket, email]
                    end
                  end.to_h
    @items = Item.where(created_at: @start..@end).
                  includes(:product).includes(:basket).
                  where.not(baskets: {locked: nil}).
                  pluck(*@attributes).map do|item|
                    item[created_index] = item[created_index].to_i*1000
                    item[price_index] = item[price_index]*item[quantity_index]
                    item << emails[ item[basket_index] ]
                    item
                  end
    @attributes << "email"
    respond_to do |format|
      format.html { render }
      format.json { render json: @items.to_json , layout: false }
    end
  end

end
