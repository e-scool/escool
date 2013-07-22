class Classroom < ActiveRecord::Base

  belongs_to :school
  belongs_to :classroom_type
  has_many :children, :dependent => :destroy
  has_many :subjects, :dependent => :destroy
  has_and_belongs_to_many :teachers, :join_table => "classrooms_teachers"
  has_many :materials, :dependent => :destroy
  has_many :communications, :dependent => :destroy
  has_many :daily_activities, :dependent => :destroy
  has_many :lunch_reports, :dependent => :destroy

  attr_accessible :name, :school_id, :teacher_ids, :classroom_type #, :classroom_type_id

  scope :by_name, order('name::bytea')

  def parents
    ids = self.children.map { |i| i.parent_id }
    self.school.parents.where(:id => ids)
  end

end