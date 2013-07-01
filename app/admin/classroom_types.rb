ActiveAdmin.register ClassroomType do
  menu false
  belongs_to :school

  index do
    column :name, :sortable => :name do |classroom|
      link_to classroom.name, admin_school_classroom_type_path(classroom.school, classroom)
    end
    default_actions
  end

  form do |f|
    f.inputs "ClassroomType" do
      f.input :name
      f.input :materials, :as => :boolean
      f.input :communications, :as => :boolean
      f.buttons
    end
  end
  
end
