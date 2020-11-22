class KolmeDController < ApplicationController

  def show
    set_template
    render( template: @template)
  end
  private
  def set_template
    return lamp if params[:id].end_with?("shade")
    @template = "kolme_d/#{params[:id]}"
  end
  def lamp
    @template = "kolme_d/shade"
    @data = send( params[:id] )
  end
  def basic_shade
    {  radius0:   20 ,
       radius100: 80 ,
       height:   180 ,
       radialSegments: 12,
       heightSegments: 18,
     }
  end
  def twisted_shade
    basic_shade.merge!( twist: 120)
  end
  def curved_shade
    basic_shade.merge!( radius25: 30 , radius50:  40 , radius75:  60)
  end
  def shade
    curved_shade.merge!( twist: 120 )
  end
end
