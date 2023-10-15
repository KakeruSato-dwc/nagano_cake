Rails.application.routes.draw do
  root to: "public/homes#top"
  get "/about" => "public/homes#about", as: "about"
  
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :admin do
    root to: "homes#top"
  end
  
  namespace :admin do
    get 'orders/show'
  end
  namespace :admin do
    get 'customers/index'
    get 'customers/show'
    get 'customers/edit'
  end
  namespace :admin do
    get 'items/new'
    get 'items/index'
    get 'items/show'
    get 'items/edit'
  end
  
 
  scope module: 'public' do
    resources :orders, only: [:new, :create, :index, :show]
  end
  scope module: 'public' do
    resources :cart_items, only: [:create, :index, :update, :destroy]
  end
  
  get "/customers/my_page" => "public/customers#show", as: "customer_my_page"
  get "/customers/information/edit" => "public/customers#edit", as: "edit_customer_information"
  patch "/customers/information" => "public/customers#update", as: "customer_information"
  get "/customers/confirm_unsubscribe" => "public/customers#confirm_unsubscribe", as: "customer_confirm_unsubscribe"
  patch "/customers/unsubscribe" => "public/customers#unsubscribe", as: "customer_unsubscribe"
  
  scope module: 'public' do
    resources :items, only: [:index, :show]
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
