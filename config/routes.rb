Splashbox::Application.routes.draw do
  root "pages#marketing"

  get '/me', to: 'dashboard#index', as: :dashboard

  get '/waitlist' => redirect('/')

  match 'auth',     via: [:get, :post], to: 'dropbox#authorize', as: :auth
  match 'callback', via: [:get],  to: 'dropbox#authorized_callback', as: :callback

  get '/logout', to: 'dropbox#destroy', as: :logout
end
