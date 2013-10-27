Escool::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  post '/admin/schools/:school_id/children/change_parents' => 'admin/children#change_parents'
  post '/admin/schools/:school_id/children/change_classrooms' => 'admin/children#change_classrooms'
end