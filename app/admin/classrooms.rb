ActiveAdmin.register Classroom do
  menu false
  belongs_to :school

  filter :name

  index do
    column :name, :sortable => :name do |classroom|
      link_to classroom.name, admin_school_classroom_path(classroom.school, classroom)
    end
    default_actions
  end

  show do
    panel "Teachers" do
      table_for classroom.teachers do
        column "name" do |t|
          link_to t.name, admin_school_teacher_path(t.school, t)
        end
      end
    end
    panel "Children" do
      table_for classroom.children do
        column "name" do |c|
          link_to c.name, admin_school_child_path(c.school, c)
        end
      end
    end
  end

  form do |f|
    f.inputs "Classroom" do
      f.input :classroom_type_id, :as => :select, :collection => classroom.school.classroom_types.all
      f.input :name
      f.input :teachers, :as => :check_boxes, :collection => classroom.school.teachers.all
      f.buttons
    end
  end

end
