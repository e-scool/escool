class Parent < User

  belongs_to :school
  belongs_to :current_child, :foreign_key => :current_child_id, :class_name => "Child"
  has_many :children, :dependent => :destroy


  def add_current_child
    self.current_child_id = self.children.first.id
    self.save
  end

end