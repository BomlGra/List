Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'tasks#index'

  resources :tasks

  patch '/done/:id', to: 'tasks#done', as: :done_task
end