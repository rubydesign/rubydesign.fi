module OfficeClerk
  class ShippingMethod
    def initialize data
      @data = data
      @name = @data[:name]
      @type = @data[:type]
      @description = @data[:description]
    end
    attr_reader :data , :name , :type , :description

    def price_for(basket)
      raise "Not implemented in #{self}"
    end
    @@methods = nil
    def self.all
      return @@methods if @@methods 
      @@methods = {}
      config = OfficeClerk.config(:shipping)
      config.each do |key , method|
        begin
          clas_name = method[:class]
          clas = clas_name.constantize
          @@methods[key] = clas.new( method.merge(:type => key) )
        rescue
          puts "No such Class #{method[:class]}, check config.yml"
        end
      end
      @@methods
    end
    def self.method(name)
      return self.all.values.first if name.nil?
      m = self.all[name.to_sym]
      m.blank? ?  self.all.values.first : m
    end
  end
  class Pickup < ShippingMethod
    def initialize data
      super(data)
    end
    def price_for(basket)
      0.0
    end
  end
end
