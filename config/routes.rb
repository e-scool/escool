Escool::Application.routes.draw do

  root :to => "website#index"

  match 'contact' => 'website#contact', :as => 'contact', :via => :get

  namespace :api, defaults: {format: 'json'} do
    resources :materials, except: [:new, :edit]
    resources :communications, except: [:new, :edit]
  end

  ActiveAdmin.routes(self)

  post "/admin/schools/:school_id/children/change_parents" => "admin/children#change_parents"
  post "/admin/schools/:school_id/children/change_classrooms" => "admin/children#change_classrooms"

  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, :path_names => {:sign_in => "login", :sign_out => "logout" }, :skip => [:registrations]

  devise_scope :user do
    get "/login" => "devise/sessions#new", :as => "login"
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
    #root to: "devise/sessions#new"
  end

  match '/update-child/:child_id' => "dashboard#update_current_child", :as => "update_current_child"
  match '/update-classroom/:classroom_id' => "dashboard#update_current_classroom", :as => "update_current_classroom"

  get "/dashboard" => "dashboard#index"

  resources :materials, only: [:index]
  resources :communications, only: [:index]

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
