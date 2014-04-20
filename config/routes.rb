Splashbox::Application.routes.draw do
  root "home#show"

  get '/waitlist',  to: 'home#index', as: :waitlist
  get '/me', to: 'home#me', as: :dashboard

  match 'auth',     via: [:get, :post], to: 'dropbox#authorize', as: :auth
  match 'callback', via: [:get],  to: 'dropbox#authorized_callback', as: :callback
end
