module NewReporter

  def new_report
    @attributes = [ "price" , "quantity" , "id", "name" ,
                    "basket_id" , "product_id" ,
                    "baskets.kori_type" , "products.category_id",
                    "products.supplier_id" , "created_at"]
    @group_names = { "all" => "All" ,
                     "products.supplier_id" => t(:supplier) ,
                     "products.category_id" => t(:category) ,
                     "product_id" => t(:product) }
    @start = params[:start] ? Time.at(params[:start].to_i) : 3.months.ago.beginning_of_month
    @end =   params[:end]   ? Time.at(params[:end].to_i)   : Date.today.end_of_month
    @items = Item.where(created_at: @start..@end).
                  includes(:product).includes(:basket).
                  where.not(baskets: {locked: nil}).
                  pluck(*@attributes).map{|i| i[-1] = i[-1].to_i*1000;i[0] = i[0]*i[1] ; i}
    @orders = Basket.unscoped.where("baskets.created_at": @start..@end).
                  includes(:order).where.not(locked: nil).
                  pluck("baskets.id" , "orders.email").to_h

    respond_to do |format|
      format.html { render }
      format.json { render json: @items.to_json , layout: false }
    end
  end

end
