Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  devise_scope :user do
    get 'users/list' => "users/sessions#list"
  end

  get 'main/index'
  get 'main/input'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "main#index"
  # mount ActionCable.server => '/cable'
end
