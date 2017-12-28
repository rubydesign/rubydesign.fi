Rails.application.routes.draw do

  mount RubyClerks::Engine => "/"
  root :to => 'sessions#sign_in' , :as => :root

end
