class Teacher < User

  belongs_to :school
  belongs_to :current_classroom, :foreign_key => :current_classroom_id, :class_name => "Classroom"
  has_and_belongs_to_many :classrooms, :join_table => "classrooms_teachers"

  attr_accessible :classrooms


  def add_current_classroom
    self.current_classroom_id = self.classrooms.first.id
    self.save
  end

  def classroom_subjects(classroom)
    classroom.subjects.where(:teacher_id => self.id).all
  end
  
end