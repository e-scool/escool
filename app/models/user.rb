class User < ActiveRecord::Base  

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :omniauthable, :confirmable
  devise :database_authenticatable, :token_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :username, :email, :password, :password_confirmation, :remember_me

  validates :username, uniqueness: true

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
    else
      where(conditions).first
    end
  end
  ### This is the correct method you override with the code above
  ### def self.find_for_database_authentication(warden_conditions)
  ### end

  # Public: Check if is User has current_child (if is Parent) or current_child (if is Teacher or SchoolManager)
  def has_child_or_classroom_assigned?
    if self.parent?
      self.current_child_id?
    elsif self.teacher? || self.school_manager?
      self.current_classroom_id?
    else
      ##
      ## Expection => No Parent/Teacher/SchoolManager User
      ##
    end
  end
  
  def parent?
    self.is_a?(Parent)
  end

  def teacher?
    self.is_a?(Teacher)
  end

  def school_manager?
    self.is_a?(SchoolManager)
  end

end