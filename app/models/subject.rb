class Subject < ActiveRecord::Base

  validates :name, :presence => true

  belongs_to :classroom
  belongs_to :teacher
  has_many :materials
  has_many :communications
  attr_accessible :name, :classroom_id, :teacher_id

end
