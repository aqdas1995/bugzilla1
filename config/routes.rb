Rails.application.routes.draw do

  # Serve websocket cable request in-process
  mount ActionCable.server => '/cable'

  get 'conversations/show'
  post 'conversations/fetch_messages'
  post 'conversations/fetch_user'
  post 'conversations/add_to_conversation'
  post 'conversations/create'

  root 'projects#index'

  resources :projects do
    resources :bugs, shallow: true do
      post :assign, on: :member
      post :resolve, on: :member
      post :start, on: :member
      post :unassign, on: :member
      get :assignable_users, on: :member
    end
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    unlocks: 'users/unlocks'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
