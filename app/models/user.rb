class User < ActiveRecord::Base

  validates :username, :uniqueness => true

  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable, :omniauthable, :confirmable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :username, :email, :password, :password_confirmation, :remember_me, :user_role
  attr_accessible :login
  attr_accessible :type


  def self.find_first_by_auth_conditions(warden_conditions)
    binding.pry
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
  ### This is the correct method you override with the code above
  ### def self.find_for_database_authentication(warden_conditions)
  ### end

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
