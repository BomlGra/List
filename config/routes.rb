Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join('|')}/ do
    devise_for :users
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    get 'tasks/text/:id' => 'tasks#get_text'
    root 'tasks#index'

    resources :tasks

    patch '/done/:id', to: 'tasks#done', as: :done_task
  end
end