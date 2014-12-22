TestApp::Application.routes.draw do

  mount OfficeClerk::Engine => "/"
  root :to => 'sessions#sign_in' , :as => :root

end
