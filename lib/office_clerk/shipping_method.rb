module OfficeClerk
  class ShippingMethod
    def initialize data
      @data = data
      @name = @data[:name]
      @id = @data[:id]
      @description = @data[:description]
    end
    attr_reader :data , :name , :id

    def price_for(basket)
      raise "Not implemented in #{self}"
    end
    @@methods = nil
    def self.all
#      return @@methods if @@methods 
      @@methods = []
      config = OfficeClerk.config(:shipping)
      config.each do |key , method|
        clas_name = method[:class]
        clas = clas_name.constantize
        @@methods << clas.new( method.merge(:id => key) )
      end
      @@methods
    end
  end
  class Pickup < ShippingMethod
    def initialize data
      super(data)
    end
    def price_for(basket)
      0
    end
  end
end
