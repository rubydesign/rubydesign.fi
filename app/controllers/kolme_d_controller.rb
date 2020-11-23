class KolmeDController < ApplicationController
  include KolmeDHelper

  def show
    set_template(params[:id])
    render( template: @template)
  end
  private
  def set_template(id)
    return lamp if id.end_with?("shade")
    @template = "kolme_d/#{id}"
  end
  def lamp
    @template = "kolme_d/shade"
    @data = send( params[:id] )
    @text = send( "#{params[:id]}_text" )
  end
  def shade
    ret = {}
    curved_shade.keys.each do |key|
      next unless val = params[key]
      ret[key] = val.to_f
    end
    ret
  end
  def basic_shade
    {  radius0:   20 ,
       radius100: 130 ,
       height:   180 ,
       radialSegments: 24,
       heightSegments: 18,
     }
  end
  def twisted_shade
    {  radius0:   20 ,
       radius100: 100 ,
       height:   180 ,
       heightSegments: 12,
       radialSegments: 8,
       twist: 120
    }
  end
  def curved_shade
    {  radius0:   20 ,
       radius25: 30 ,
       radius50:  40 ,
       radius75:  60 ,
       radius100: 130 ,
       height:   180 ,
       heightSegments: 18,
       radialSegments: 100,
     }
  end
  def pair_shade
    {  radius0:   30 ,
       radius25: 1 ,
       radius50:  75 ,
       radius75:  90 ,
       radius100: 50 ,
       height:   250 ,
       heightSegments: 24,
       radialSegments: 16,
       twist: 120
    }
  end
  def bell_shade
    {  radius0:   30 ,
       radius25:  30 ,
       radius50:  70 ,
       radius75: 120 ,
       radius100: 80 ,
       height:   160 ,
       heightSegments: 12,
       radialSegments: 18 ,
       twist: 120
    }
  end
end
