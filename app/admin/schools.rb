ActiveAdmin.register School do

  filter :name

  index do
    column :name, :sortable => :name do |school|
      link_to school.name, [:admin, school]
    end
    default_actions
  end

  show do
    panel "Classroom Types" do
      table_for school.classroom_types do
        column "name" do |c|
          link_to c.name, admin_school_classroom_type_path(school, c)
        end
      end
      strong { link_to "View All Classrooms Types (#{school.classroom_types.count})", admin_school_classroom_types_path(school) }
    end
    panel "Classrooms" do
      table_for school.classrooms do
        column "name" do |c|
          link_to c.name, admin_school_classroom_path(school, c)
        end
        column "type" do |c|
          link_to c.classroom_type.name, admin_school_classroom_type_path(school, c.classroom_type)
        end
      end
      strong { link_to "View All Classrooms (#{school.classrooms.count})", admin_school_classrooms_path(school) }
    end
    panel "School Managers" do
      table_for school.school_managers do
        column "name" do |c|
          link_to c.name, admin_school_school_manager_path(school, c)
        end
      end
      strong { link_to "View All School Managers", admin_school_school_managers_path(school) }
    end
    panel "Teachers" do
      table_for school.teachers do
        column "name" do |c|
          link_to c.name, admin_school_teacher_path(school, c)
        end
      end
      strong { link_to "View All Teachers (#{school.teachers.count})", admin_school_teachers_path(school) }
    end
    panel "Children" do
      strong { link_to "View All Children (#{school.children.count})", admin_school_children_path(school) }
    end
    panel "Parents" do
      strong { link_to "View All Parents (#{school.parents.count})", admin_school_parents_path(school) }
    end
  end
end
