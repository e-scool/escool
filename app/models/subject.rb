class Subject < ActiveRecord::Base

  validates :name, :presence => true

  belongs_to :classroom
  belongs_to :teacher

  attr_accessible :name, :classroom_id, :teacher_id

end
