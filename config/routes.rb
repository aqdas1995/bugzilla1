Rails.application.routes.draw do
  get 'dummy/index'
  root 'dummy#index'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    unlocks: 'users/unlocks'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
