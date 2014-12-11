class ShopController < OfficeController
  before_action :load

  layout "sales_clerk"

  def welcome
    @groups = Category.online.where( :category_id => nil )
    render :layout => false
  end

  def product
    @product = Product.shop_products.where(:link => params[:link]).first
    unless @product
      redirect_to :action => :group 
      return
    end
    @group = @product.category
    #error handling
#    @group = Category.find(@product.category_id)
  end

  # the checkout page creates an order upon completion. So before a checkout the basket is attached to the session
  # and by filling out all data an order is created with the basket and the session zeroed
  def checkout
    @order = Order.new :ordered_on => Date.today
    @order.basket = current_basket
    if(request.get?)
      @order.email = current_clerk.email if current_clerk
      @order.shipment_type = "pickup" # price is 0 automatically
    else
      order_ps = params.require(:order).permit( :email,:name , :street , :city , :phone , :shipment_type )
      if @order.update_attributes(order_ps)
        new_basket
        OrderMailer.confirm(@order).deliver
        redirect_to shop_order_path(@order), :notice => t(:thanks)
        return
      end
    end
  end

  def order
    if( params[:id])
      @order = Order.find( params[:id] )
    else
      raise "last order of logged person"
    end
  end

  def add
    prod = Product.find( params[:id]) # no id will raise which in turn will show home page
    current_basket.add_product(prod)
    if request.get?
      redirect_to shop_checkout_path
    else
      flash.notice = "#{t(:product_added)}: #{prod.name}"
      redirect_to shop_group_path(prod.category.link)
    end
  end
  def remove
    prod = Product.find( params[:id]) # no id will raise which in turn will show home page
    current_basket.add_product(prod , -1)
    redirect_to shop_checkout_path
  end

  def group
    @group = Category.online.where(:link => params[:link]).first 
    if @group
      @products = @group.shop_products
      template = "product_list"
      @groups = @group.categories.online
    else
      @groups = Category.online.where( :category_id => nil )
      template = "main_group"
    end
    render template
  end

  def page
    @products = Product.shop_products.limit(50)
    template = params[:id]
    template = "tuotteista" if template.blank?
    render template
  end
  private
    def load
      @menu =  {"/page/kotisivu" => "KOTISIVU" ,
                "/group/start" => "VERKKOKAUPPA" ,
                "/page/tuotteista" => "TUOTTEISTA",
                "/page/toimitusehdot" => "TOIMITUSEHDOT" ,
                "/page/liike" => "LIIKKEEMME" }
    end
end
