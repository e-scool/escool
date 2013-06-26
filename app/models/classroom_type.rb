class ClassroomType < ActiveRecord::Base

  belongs_to :school

  attr_accessible :name, :school_id, :materials, :communications, :daily_activities, :lunch_reports
end
