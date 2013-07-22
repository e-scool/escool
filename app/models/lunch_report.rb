class LunchReport < ActiveRecord::Base

  validates :date, :presence => true
  validates :status, :presence => true
  validates :child_id, :presence => true

  belongs_to :classroom		
  belongs_to :child

  attr_accessible :date, :status, :classroom_id, :child_id

end
