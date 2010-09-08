Haikufire::Application.routes.draw do
  match '/' => 'news#index'
  resources :users
  resources :softwares
  match '/auth/login' => 'users#login', :as => :login
  match '/auth/logout' => 'users#logout', :as => :logout
  match '/simple_captcha(/:action)' => 'simple_captcha', :as => :simple_captcha
  match '/:controller(/:action(/:id))'
end
