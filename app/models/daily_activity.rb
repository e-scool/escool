class DailyActivity < ActiveRecord::Base

  validates :title, :presence => true
  validates :date, :presence => true
  validates :body, :presence => true

  belongs_to :classroom
  has_and_belongs_to_many :children, :join_table => "children_daily_activities"

  attr_accessible :title, :date, :body

end