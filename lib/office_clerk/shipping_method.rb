module OfficeClerk
  class ShippingMethod
    def initialize data
      @data = data
    end
    attr_reader :data
    def name
      @data[:name]
    end
    def id
      @data[:id]
    end
    def price(basket)
      5
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
  end
  class Postal < ShippingMethod
    def initialize data
      super data
    end
  end
end
