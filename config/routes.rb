OfficeClerk::Application.routes.draw do
  resources :shops

  root :to => 'shop#group'

  get "sign_out" => "sessions#destroy", :as => "sign_out"
  get "sign_in"  => "sessions#new",     :as => "sign_in"
  get "sign_up" => "sessios#new_user", :as => "sign_up"
#  root :to => "users#new"

  resources :sessions do
    member do
      get :new_user
      get :create_user
    end
  end
  
  resources :purchases do
    collection do
      match "search" => "purchases#index", :via => [:get, :post]
    end
    member do
      get :order
      get :receive
      get :inventory
    end
  end

  resources :baskets do
    collection do
      match "search" => "baskets#index", :via => [:get, :post]
    end
    member do
      get :order
      get :purchase
      get :print
    end
  end

  resources :orders do
    collection do
      match "search" => "orders#index", :via => [:get, :post]
    end
    member do
      get :print
    end
  end

  resources :items do
    collection do
      match "search" => "items#index", :via => [:get, :post]
    end
    member do
    end
  end

  resources :categories do
    collection do
      match "search" => "categories#index", :via => [:get, :post]
    end
    member do
    end
  end

  resources :products do
    collection do
      match "search" => "products#index", :via => [:get, :post]
    end
    member do
      get :delete
      get :barcode  #print the barcode and price on a 50x25 mm area
    end
  end

  resources :users do
    collection do
      match "search" => "users#index", :via => [:get, :post]
    end
    member do
    end
  end

  resources :addresses do
    collection do
      match "search" => "addresses#index", :via => [:get, :post]
    end
  end

  resources :suppliers do
    collection do
      match "search" => "suppliers#index", :via => [:get, :post]
    end
    member do
    end
  end
  
  #shop
  get 'group/:id' => 'shop#group', :as => :group
  get 'prod/:id' => 'shop#product', :as => :prod
  get 'page/:id' => 'shop#page', :as => :page
end