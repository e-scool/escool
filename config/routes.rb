Escool::Application.routes.draw do
  root to: 'website#index'

  match 'contact' => 'website#contact', as: 'contact', via: :get

  get '/dashboard' => 'dashboard#index'

  match '/update-child/:child_id' => 'dashboard#update_current_child', as: 'update_current_child'
  match '/update-classroom/:classroom_id' => 'dashboard#update_current_classroom', as: 'update_current_classroom'

  devise_for :users, path_names: {sign_in: 'login', sign_out: 'logout'}, skip: [:registrations]

  devise_scope :user do
    get '/login' => 'devise/sessions#new', as: 'login'
    get '/logout' => 'devise/sessions#destroy', as: 'logout'
    get 'users/edit' => 'devise/registrations#edit', as: 'edit_user_registration'
    put 'users' => 'devise/registrations#update', as: 'user_registration'
  end
end
