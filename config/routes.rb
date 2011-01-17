Grokphoto::Application.routes.draw do

  root :to => "home#index"
  # grifs serving file uploads
  # match "/images/uploads/*path" => "gridfs#serve"
  match 'timestamp' => 'home#timestamp' # used to keep passenger spooled up in prod
  map.resources :sitemap

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
      put :update_position, :on => :member
      resources :gallery_photos do
        put :update_position, :on => :member
        post :flash_upload, :on => :collection
      end
    end
    resources :clients do
      get :invite, :on => :member
      resources :bookings do
        resources :booking_photos do
          get :ajax_row, :on => :member
          post :flash_upload, :on => :collection
          resources :comments
        end
      end
    end
    resources :pages do
      put :update_position, :on => :member
    end
    resources :testimonials do
      put :update_position, :on => :member
    end
  end
  
end
