OfficeClerk::Application.routes.draw do
  resources :shops

  resources :purchases do
    collection do
      match "search" => "purchases#index", :via => [:get, :post]
    end
    member do
    end
  end

  resources :baskets do
    collection do
      match "search" => "baskets#index", :via => [:get, :post]
    end
    member do
      get :order 
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

  root :to => 'shop#group'

  devise_for :users, :controllers => {:registrations => "registrations"}

  #shop
  get 'group/:id' => 'shop#group', :as => :group
  get 'prod/:id' => 'shop#product', :as => :prod
  get 'page/:id' => 'shop#page', :as => :page
end