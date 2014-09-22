Splashbox::Application.routes.draw do
  root "pages#marketing"

  get '/me', to: 'dashboard#index', as: :dashboard

  get '/waitlist' => redirect('/')

  match 'auth',     via: [:get, :post], to: 'dropbox#authorize', as: :auth
  match 'callback', via: [:get],  to: 'dropbox#authorized_callback', as: :callback

  get '/logout', to: 'dropbox#destroy', as: :logout

  get '/privacy' => redirect('https://drive.google.com/file/d/0B1zCBHrHbPIccTNWMVVid1lVd1U/edit?usp=sharing')

  resources :charges, only: :create
end
