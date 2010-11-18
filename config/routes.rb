Grokphoto::Application.routes.draw do

  root :to => "home#index"

  resources :galleries
  resources :gallery_photos
  resources :pages
  resources :testimonials
  
  devise_for :clients

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
    resources :galleries do
      resources :gallery_photos #member { put 'update_position' }
    end
    resources :clients do
      resources :bookings do
        resources :booking_photos do
          resources :comments
        end
      end
    end
    resources :pages
    resources :testimonials
  end
  
end
