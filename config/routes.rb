OfficeClerk::Application.routes.draw do
  match "users/search_and_filter" => "users#index", :via => [:get, :post], :as => :search_users
  resources :users do
    collection do
      post :batch
      get  :treeview
    end
    member do
      post :treeview_update
    end
  end

  match "addresses/search_and_filter" => "addresses#index", :via => [:get, :post], :as => :search_addresses
  resources :addresses do
    collection do
      post :batch
      get  :treeview
    end
    member do
      post :treeview_update
    end
  end

  match "suppliers/search_and_filter" => "suppliers#index", :via => [:get, :post], :as => :search_suppliers
  resources :suppliers do
    collection do
      post :batch
      get  :treeview
    end
    member do
      post :treeview_update
    end
  end

  root :to => 'beautiful#dashboard'
  match ':model_sym/select_fields' => 'beautiful#select_fields', :via => [:get, :post]

  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
end