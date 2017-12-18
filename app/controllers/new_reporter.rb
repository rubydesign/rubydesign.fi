module NewReporter

  def new_report
    set_instance_data
    search = build_search
    if (@group_by == "by_category")
      table = Item.includes(:product => :category)
    else
      table = Item.includes(:product)
    end
    @search = table.ransack(search)
    @flot_options = { :series => {  :bars =>  { :show => true , :barWidth => @days * 24*60*60*1000 }  } ,
                      :legend => {  :container => "#legend"} ,
                      :xaxis =>  { :mode => "time" }
                    }               #last attribute must be created_at
    @attributes = ["id", "baskets.kori_type" , "products.category_id",
                    "quantity" , "created_at"]
    @items = Item.where(created_at: 3.months.ago..Date.today).
                  includes(:product).includes(:basket).
                  where.not(baskets: {locked: nil}).
                  pluck(*@attributes).map{|i| i[-1] = i[-1].to_i*1000 ; i}
#    group_data
  end

  private

  def set_instance_data
    @type = params[:type] || "Order"
    @period = params[:period] || "week"
    @days = 1
    @days = 7 if @period == "week"
    @days = 30.5 if @period == "month"
    @price_or = (params[:price_or] || "total").to_sym
    @group_by = (params[:group_by] || "all" )
  end

  def build_search
    search = params[:q] || {}
    search[:meta_sort] = "created_at asc"
    if search[:created_at_gt].blank?
      search[:created_at_gt] = short_date(Time.now - 3.months)
    else
      search[:created_at_gt] =
        begin
          short_date(Time.zone.parse(search[:created_at_gt]).beginning_of_day)
        rescue
          I18n.l(Time.zone.now.beginning_of_month)
        end
    end
    unless search[:created_at_lt].blank?
      begin
        search[:created_at_lt] = short_date(Time.zone.parse(search[:created_at_lt]).end_of_day)
      rescue
      end
    end
    search[:order_completed_at_present] = true
    search[:basket_kori_type_eq] = @type
    search
  end

  def short_date d
    d = d.to_date unless d.is_a? Date
    I18n.l( d , :format => :default)
  end

  def group_data
    all = @search.result(:distinct => true )
    flot = {}
    smallest = all.first ? all.first.created_at : Time.now - 1.week
    largest = all.first ? all.last.created_at : Time.now
    smallest = all.first ? all.first.created_at : Time.now - 1.week
    largest = all.first ? all.last.created_at : Time.now
    if( @group_by == "all" )
      flot["all"] = all
    else
      all.each do |item|
        bucket = get_bucket(item)
        flot[ bucket ] = [] unless flot[bucket]
        flot[ bucket ] << item
      end
    end
    flot_data = flot.collect do |label , data |
      buck = bucket_array( data , smallest , largest )
      sum = buck.inject(0.0){|total , val | total + val[1] }.round(2)
      { :label => "#{label} =#{sum}" , :data => buck }
    end
    @flot_data = flot_data.sort{ |a,b| b[:label].split("=")[1].to_f <=> a[:label].split("=")[1].to_f }
  end

  def get_bucket item
    return "all" if @group_by == "all"
    case @group_by
    when "by_category"
      item.product.category.blank? ? "blank" : item.product.category.name
    when "by_supplier"
      item.product.supplier.blank? ? "blank" : item.product.supplier.supplier_name
    when "by_product"
      item.product.full_name
    when "by_product_line"
      item.product.product ? item.product.product.name : item.product.name
    when "by_email"
      item.basket.kori.email
    else
      pps = item.product.properties.detect{|p,v| p == @group_by}
      pps ? pps.value : "blank"
    end
  end

  # a new bucketet array version is returned
  # a value is creted for every tick between from and two (so all arrays have same length)
  # ticks int he returned array are javascsript times ie milliseconds since 1970
  def bucket_array( array  , from , to )
    rb_tick = (@days * 24 * 60 * 60).to_i
    js_tick = rb_tick * 1000
    from = (from.to_i / rb_tick) * js_tick
    to = (to.to_i / rb_tick)* js_tick
    ret = {}
    while from <= to
      ret[from] = 0
      from += js_tick
    end
    array.each do |item|
      value = item.send(@price_or)
      index = (item.created_at.to_i / rb_tick)*js_tick
      if ret[index] == nil
        puts "No index #{index} in array (for bucketing) #{ret.to_json}" if Rails.env == "development"
        ret[index] = 0
      end
      ret[index] = ret[index] + value
    end
    ret.sort
  end

end
