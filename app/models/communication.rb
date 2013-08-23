class Communication < ActiveRecord::Base

  validates :title, :presence => true
  validates :date, :presence => true
  validates :body, :presence => true

  belongs_to :classroom
  belongs_to :subject
  has_and_belongs_to_many :children, :join_table => "children_communications"

  attr_accessible :classroom, :subject, :title, :date, :body

  default_scope order("date DESC")

end