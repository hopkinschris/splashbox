Splashbox::Application.routes.draw do
  root "home#show"

  match 'auth',     via: [:post], to: 'dropbox#authorize', as: :auth
  match 'callback', via: [:get],  to: 'dropbox#authorized_callback', as: :callback
end
