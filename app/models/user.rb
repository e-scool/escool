class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :omniauthable, :confirmable
  devise :database_authenticatable, :token_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

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
  ### This is the correct method overrided with the code above
  ### def self.find_for_database_authentication(warden_conditions)
  ### end

  # Public: Checks if this user has current_child (if it's a Parent) or
  # current_classroom (if it's a Teacher or SchoolManager).
  #
  # Returns True/False.
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

  # Public: Checks if this user is a Parent.
  #
  # Returns True/False.
  def parent?
    self.is_a?(Parent)
  end

  # Public: Checks if this user is a Teacher.
  #
  # Returns True/False.
  def teacher?
    self.is_a?(Teacher)
  end

  # Public: Checks if this user is a SchoolManager.
  #
  # Returns True/False.
  def school_manager?
    self.is_a?(SchoolManager)
  end

end