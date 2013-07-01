ActiveAdmin.register Child do
  belongs_to :school

  index do
    column :name, :sortable => :name do |child|
      link_to child.name, admin_school_child_path(child.school, child)
    end
    column :classroom do |child|
      link_to child.classroom.name, admin_school_classroom_path(child.school, child.classroom)
    end
    column :parent do |child|
      link_to child.parent.name, admin_school_parent_path(child.school, child.parent)
    end
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :school, :input_html => {
          :onchange => admin_remote_request(:post, :change_classrooms, :child_classroom_id, {:child_school_id => "$('#child_school_id').val()"})
      }
      f.input :classroom, :input_html => {
          :onchange => admin_remote_request(:post, :change_parents, :child_parent_id, {:classroom_id => "$('#child_classroom_id').val()"})
      }
      f.input :parent
      f.input :name
      f.buttons
    end
  end

  controller do
    def change_parents
      @parents = Classroom.find_by_id(params[:classroom_id]).parents
      render :text => view_context.options_from_collection_for_select(@parents, :id, :name)
    end
    def change_classrooms
      @classrooms = School.find_by_id(params[:child_school_id]).classrooms
      render :text => view_context.options_from_collection_for_select(@classrooms, :id, :name)
    end
  end

end
