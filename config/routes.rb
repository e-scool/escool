Escool::Application.routes.draw do

  root to: 'website#index'

  match 'contact' => 'website#contact', as: 'contact', via: :get

  namespace :api, defaults: {format: 'json'} do
    resources :sessions, only: [:create, :destroy]
    resources :children, only: [:index]
    resources :communications, only: [:index, :show] # :create, :update, :destroy
    resources :materials, only: [:index, :show] # :create, :update, :destroy]
  end

  ActiveAdmin.routes(self)

  post '/admin/schools/:school_id/children/change_parents' => 'admin/children#change_parents'
  post '/admin/schools/:school_id/children/change_classrooms' => 'admin/children#change_classrooms'

  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, path_names: {sign_in: 'login', sign_out: 'logout'}, skip: [:registrations]

  devise_scope :user do
    get '/login' => 'devise/sessions#new', as: 'login'
    get 'users/edit' => 'devise/registrations#edit', as: 'edit_user_registration'
    put 'users' => 'devise/registrations#update', as: 'user_registration'
    # root to: 'devise/sessions#new'
  end

  match '/update-child/:child_id' => 'dashboard#update_current_child', as: 'update_current_child'
  match '/update-classroom/:classroom_id' => 'dashboard#update_current_classroom', as: 'update_current_classroom'

  get '/dashboard' => 'dashboard#index'

  resources :materials, only: [:index]
  resources :communications, only: [:index]

end
