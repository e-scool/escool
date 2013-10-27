Escool::Application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    resources :sessions,        only: [:create, :destroy]
    resources :children,        only: [:index]
    resources :communications,  only: [:index, :show] # :create, :update, :destroy
    resources :materials,       only: [:index, :show] # :create, :update, :destroy]
    resources :users,           only: [:show, :index]
  end
end