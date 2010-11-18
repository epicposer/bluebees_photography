Grokphoto::Application.routes.draw do

  root :to => "home#index"

  resources :galleries
  resources :gallery_photos
  resources :pages
  resources :testimonials
  
  devise_for :clients
  devise_for :photographers

  match 'client' => 'client/bookings#index'
  namespace :client do    
    resources :bookings do
      resources :booking_photos do
        resources :comments
      end
    end
  end
  
  match 'admin' => 'admin/clients#index'
  namespace :admin do
    resource :photographer
    resources :galleries do
      member { put 'update_position' }
      resources :gallery_photos do
        member { put 'update_position' }
      end
    end
    resources :clients do
      member { get 'invite' }
      resources :bookings do
        resources :booking_photos do
          resources :comments
        end
      end
    end
    resources :pages do
      member { put 'update_position' }
    end
    resources :testimonials do
      member { put 'update_position' }
    end
  end
  
end
