TestApp::Application.routes.draw do

  get '/group/:link' , :to => 'office#group', :as => :shop_group
  mount OfficeClerk::Engine => "/"
  root :to => 'sessions#sign_in' , :as => :root

end
