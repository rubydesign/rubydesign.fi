TestApp::Application.routes.draw do
  root :to => 'sessions#sign_in'
  get '/group/:link' , :to => 'office#group', :as => :shop_group
  mount OfficeClerk::Engine => "/"

end
