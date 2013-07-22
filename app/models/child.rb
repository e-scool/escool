class Child < ActiveRecord::Base

  validates :name, :presence => true
  validates :school_id, :presence => true
  validates :classroom_id, :presence => true
  validates :parent_id, :presence => true

  belongs_to :school
  belongs_to :classroom
  belongs_to :parent
  has_and_belongs_to_many :materials, :join_table => "children_materials"
  has_and_belongs_to_many :communications, :join_table => "children_communications"
  has_and_belongs_to_many :daily_activities, :join_table => "children_daily_activities"
  has_many :lunch_reports

  attr_accessible :school_id, :name, :classroom, :parent #, :classroom_id, :parent_id

  after_create :add_current_child_to_parent

  def add_current_child_to_parent
    parent = self.parent
    parent.current_child_id = self.id
    parent.save
  end

end