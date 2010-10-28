Haikufire::Application.routes.draw do
  get "downloads/edit"

  get "downloads/update"

  get "downloads/delete"

  get "downloads/destroy"

  get "downloads/get"

  match '/' => 'news#index'
  resources :categories
  resources :users
  resources :softwares
  match '/auth/login' => 'users#login', :as => :login
  match '/auth/logout' => 'users#logout', :as => :logout
  match '/simple_captcha(/:action)' => 'simple_captcha', :as => :simple_captcha
  match '/:controller(/:action(/:id))'
end
