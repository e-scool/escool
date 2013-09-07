class Material < ActiveRecord::Base

  validates :title, presence: true
  validates :date, presence: true
  validates :body, presence: true

  belongs_to :classroom
  belongs_to :subject
  has_and_belongs_to_many :children, join_table: "children_materials"

  attr_accessible :classroom, :children, :subject, :title, :date, :subject

  default_scope order("date DESC")

end