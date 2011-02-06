Grokphoto::Application.routes.draw do

  # theme support
  themes_for_rails

  root :to => "home#index"
  # grifs serving file uploads
  # match "/images/uploads/*path" => "gridfs#serve"
  match 'timestamp' => 'home#timestamp' # used to keep passenger spooled up in prod
  resources :sitemap

  resources :galleries do
    resources :gallery_photos
  end
  resources :portfolios do
    resources :portfolio_photos
  end
  resources :pages

  devise_for :photographers

  match 'photog' => 'photog/galleries#index'
  namespace :photog do
    resource :photographer
    resources :portfolios do
      put :update_position, :on => :member
      resources :portfolio_photos do
        put :update_position, :on => :member
        post :flash_upload, :on => :collection
      end
    end
    resources :galleries do
      get :invite, :on => :member
      resources :gallery_photos do
        get :ajax_row, :on => :member
        post :flash_upload, :on => :collection
      end
    end
    resources :pages do
      put :update_position, :on => :member
    end
  end

end
