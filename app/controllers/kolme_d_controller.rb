class KolmeDController < ApplicationController
  include KolmeDHelper

  def show
    set_data
    render( template: @template)
  end
  private
  def set_data
    id = params[:id]
    @template = "kolme_d/#{id}"
    set_lamp_data if all_shades.include?(id.to_sym)
  end
  def set_lamp_data
    @template = "kolme_d/shade"
    send( params[:id] )
    @header , @text = send( "#{params[:id]}_text" )
  end
  def shade
    @data = {}
    bell_shade.keys.each do |key|
      next unless val = params[key]
      @data[key] = val.to_f
    end
  end
  def basic_shade
    @data = {  radius0:   20 ,
       radius100: 130 ,
       height:   180 ,
       radialSegments: 24,
       heightSegments: 18,
     }
  end
  def twisted_shade
    @data = {  radius0:   20 ,
       radius100: 100 ,
       height:   180 ,
       heightSegments: 12,
       radialSegments: 8,
       twist: 120
    }
  end
  def curved_shade
    @data = {  radius0:   20 ,
       radius25: 30 ,
       radius50:  40 ,
       radius75:  60 ,
       radius100: 130 ,
       height:   200 ,
       heightSegments: 18,
       radialSegments: 100,
     }
  end
  def pair_shade
    @data = {  radius0:   40 ,
       radius25: -10 ,
       radius50:  60 ,
       radius75:  120 ,
       radius100: 45 ,
       height:   300 ,
       heightSegments: 20 ,
       radialSegments: 10,
       twist: 240
    }
  end
  def bell_shade
    @data = {  radius0:   30 ,
       radius25:  30 ,
       radius50:  90 ,
       radius75: 150 ,
       radius100: 100 ,
       height:   250 ,
       heightSegments: 12,
       radialSegments: 18 ,
       twist: 120
    }
  end
end
