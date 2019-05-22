Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'users/sessions', :registrations => "users/registrations" }
  devise_scope :user do
    get 'users/list' => "users/sessions#list"
  end

  get 'main/index'
  get 'main/input'

  #match 'ext/*path' => 'proxy#index', via: [:get, :post, :put, :patch, :delete]
  #match 'ext' => 'proxy#index', via: [:get, :post, :put, :patch, :delete]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #constraints(:host => /devel/) do |a|
  #  match "(*path)" => 'proxy#index', via: [:get, :post, :put, :patch, :delete]
  #end

  root "main#index"
  # mount ActionCable.server => '/cable'
end
