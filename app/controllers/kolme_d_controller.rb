class KolmeDController < ApplicationController

  def show
    set_template
    render( template: @template)
  end
  private
  def set_template
    return lamp if ["shade"].include?(params[:id])
    @template = "kolme_d/#{params[:id]}"
  end
  def lamp
    @template = "kolme_d/shade"
    @dat = basic_lamp
  end
  def basic_lamp
    {  radius0:   20 ,
       radius25:  30 ,
       radius50:  40 ,
       radius75:  60 ,
       radius100: 80 ,
       height:   180 ,
       twist:    120,
       radialSegments: 12,
       heightSegments: 18,
       orbital: false,
  }
  end
end
