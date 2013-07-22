class School < ActiveRecord::Base

  has_many :classrooms, :dependent => :destroy
  has_many :classroom_types, :dependent => :destroy
  has_many :teachers, :dependent => :destroy
  has_many :school_managers, :dependent => :destroy
  has_many :parents, :dependent => :destroy
  has_many :children, :dependent => :destroy

  attr_accessible :name

end
