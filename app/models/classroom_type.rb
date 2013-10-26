class ClassroomType < ActiveRecord::Base

  OPTIONAL_SECTIONS = %w( communications materials ) # 'daily_activities', 'lunch_reports'

  belongs_to :school

  attr_accessible :name, :school_id, :materials, :communications, :daily_activities, :lunch_reports

  # Public: Return the active sections of this ClassroomType, with their correct
  # order.
  #
  # Returns an Array.
  def active_sections
    sections = ['dashboard']

    OPTIONAL_SECTIONS.each do |section|
      sections << section if eval("self.#{section}?")
    end

    sections
  end

end