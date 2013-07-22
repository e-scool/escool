class Communication < ActiveRecord::Base

  validates :title, :presence => true
  validates :date, :presence => true
  validates :body, :presence => true
  validates :subject_id, :presence => true

  belongs_to :classroom
  belongs_to :subject
  has_and_belongs_to_many :children, :join_table => "children_communications"

  attr_accessible :title, :date, :body, :subject_id, :child_ids #:file

  #mount_uploader :file, FileUploader

  default_scope order("date DESC")

end