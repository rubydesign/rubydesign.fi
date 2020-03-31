# encoding : utf-8
# semi open read api point(s) returning json

class ApiController < ApplicationController
  layout false

  def purchase
    @purchase = Purchase.find(393)
  end

end
