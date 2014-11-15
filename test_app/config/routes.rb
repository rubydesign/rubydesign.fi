TestApp::Application.routes.draw do
  root :to => 'sessions#sign_in'
  mount OfficeClerk::Engine => "/"
end
