ActiveAdmin.register User do
  menu false

  index do
    column :type
    column :username
    column :email
    column :created_at
    default_actions
  end

  filter :email

  form do |f|
    f.inputs "User" do
      f.input :email
      f.input :username
      f.input :password
      f.input :password_confirmation
      f.buttons
    end
  end

end
