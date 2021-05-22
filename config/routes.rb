Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   namespace :admin do
     get "/" => "homes#top"
     resources :items, only: [:index, :new, :create, :show, :edit, :update]
     resources :genres, only: [:index, :create, :edit, :update]
     resources :customers, only: [:index, :show, :edit, :update]
   end

  devise_for :admin, controllers: {
    sessions:     'admin/sessions',
    passwords:    'admin/passwords',
    registrations: 'admin/registrations'
  }

  devise_for :customer, controllers: {
    sessions:     'public/sessions',
    passwords:    'public/passwords',
    registrations: 'public/registrations'
  }

    scope module: :public do

    resources :items, only: [:index, :show]
    resources :customers, only: [:show, :edit, :update]
    get '/about' => 'homes#about'
    get '/' => 'homes#top'
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items, only: [:create, :index, :update, :destroy]
    get '/orders/complete' => 'orders#complete'
    resources :orders, only: [:new, :create, :index, :show]
    post '/orders/confirm' => 'orders#confirm'
    resources :ships, only: [:index, :create, :edit, :update, :show, :destroy]

    end

end
