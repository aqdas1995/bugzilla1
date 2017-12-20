Rails.application.routes.draw do
  get 'bug_user/assign'

  get 'bugs/new'

  get 'bug/new'

  get 'projects/index'

  get 'dummy/index'
  root 'projects#index'

  resources :projects do
    resources :bugs, shallow: true
  end

  post 'bugs/assign'
  post 'bugs/unassign'
  post 'bugs/resolve'
  get 'bugs/:id/assignable_users', to: 'bugs#assignable_users', as: 'bug_assignable_users'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    unlocks: 'users/unlocks'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
