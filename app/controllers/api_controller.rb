# encoding : utf-8
# semi open read api point(s) returning json

class ApiController < ApplicationController
  layout false

  def purchase
    @purchase = Purchase.first
  end

end
