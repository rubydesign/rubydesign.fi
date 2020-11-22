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
       radialSegments: 8,
       heightSegments: 12,
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
       radialSegments: 100,
       heightSegments: 18,
     }
  end
  def pair_shade
    {  radius0:   20 ,
       radius25: 10 ,
       radius50:  40 ,
       radius75:  90 ,
       radius100: 50 ,
       height:   180 ,
       radialSegments: 8,
       heightSegments: 12,
       twist: 120
    }
  end
  def bell_shade
    {  radius0:   20 ,
       radius25:  30 ,
       radius50:  70 ,
       radius75: 120 ,
       radius100: 80 ,
       height:   180 ,
       radialSegments: 22,
       heightSegments: 12,
       twist: 120
    }
  end
end
