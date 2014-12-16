OfficeClerk::Engine.routes.draw do

  get "sign_out" => "sessions#sign_out"
  get "sign_in"  => "sessions#sign_in"
  post "create_session"  => "sessions#create" 
  match "sign_up" => "sessions#sign_up" , :via => [:get ,:post]

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
      get :discount
      post :ean
      get :order
      get :purchase
      get :checkout
    end
  end

  resources :orders do
    collection do
      match "search" => "orders#index", :via => [:get, :post]
    end
    member do
      get "mail/:act" , :action => :mail , :as => :mail
      get :pay
      get :ship
      patch :ship
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

  resources :clerks do
    collection do
      match "search" => "clerks#index", :via => [:get, :post]
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

  match "manage/all" => "manage#all", :via => [:get, :post]
    
end