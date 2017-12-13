Rails.application.routes.draw do
  
  get 'signup' => 'user#signup'
  post 'signup' => 'user#create'

  get 'login' => 'user#login'
  post 'login' => 'user#authentication'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
