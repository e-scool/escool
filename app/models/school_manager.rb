class SchoolManager < User

  # belongs_to :school
  # belongs_to :current_classroom, :foreign_key => :current_classroom_id, :class_name => "Classroom"

  # def classrooms
  #   self.school.classrooms
  # end

  # def add_current_classroom
  #   self.current_classroom_id = self.classrooms.first.id
  #   self.save
  # end

end