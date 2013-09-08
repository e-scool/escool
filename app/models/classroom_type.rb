class ClassroomType < ActiveRecord::Base

  OPTIONAL_SECTIONS = %w( communications materials ) # 'daily_activities', 'lunch_reports'

  belongs_to :school

  attr_accessible :name, :school_id, :materials, :communications, :daily_activities, :lunch_reports

end