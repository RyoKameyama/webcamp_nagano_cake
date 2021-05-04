Rails.application.routes.draw do
  devise_for :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   namespace :admin do
     get "/" => "homes#top"
     resources :items, only: [:index, :new, :create, :show, :edit, :update]
     resources :genres, only: [:index, :create, :edit, :update]
     resources :customers, only: [:index, :show, :edit, :update]
   end

    get '/about' => 'homes#about'


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
  
    namespace :public do
    resources :items, only: [:index]
    resources :customers, only: [:show]
    end

end
