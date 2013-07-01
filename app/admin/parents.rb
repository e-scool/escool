ActiveAdmin.register Parent do
  menu false
  belongs_to :school

  index do
    column :name
    column :username
    column :email
    column :created_at
    default_actions
  end

  filter :email

  form do |f|
    f.inputs "User" do
      f.input :name
      f.input :email
      f.input :username
      f.input :password
      f.input :password_confirmation
      f.buttons
    end
  end
end
