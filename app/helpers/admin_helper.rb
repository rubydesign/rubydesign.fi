# encoding : utf-8
module AdminHelper

  def sort_date key
    return "" unless params[:q]
    params[:q][key] || ""
  end

  # define a bunch of defaults for the best_in_place call
  # save and cancel buttons with internationlized texts
  # bootstrap form class
  # a default note
  # same signature as best_in_place, ie object, field symbol , hash
  def in_place object , field , attributes ={}
    defaults = { :ok_button => I18n.t(:edit), :ok_button_class => "btn btn-success" ,
                 :cancel_button => I18n.t(:cancel) , :cancel_button_class => "btn btn-warning",
                 :place_holder => I18n.t(:edit)  , :inner_class => "form-control" }
    attributes.reverse_merge! defaults
    best_in_place(object , field , attributes)
  end

  def office_assets
    engines = Rails::Engine.subclasses.map(&:instance)
    engines << Rails.application
    engines.delete_if {|e| ! e.respond_to?(:office_assets) }
    assets = engines.collect{ |e| e.office_assets }
    assets.compact
  end

  # helper so one doesn't hav to write the funny content_for in templates
  def title(page_title)
    content_for(:title) { page_title }
  end
end
