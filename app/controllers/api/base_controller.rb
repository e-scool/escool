class Api::BaseController < ActionController::Base
  before_filter :authenticate_user!

  respond_to :json

  helper_method :current_child,
                :current_classroom

  # Public: Helper method to get current classroom.
  #
  # Returns a Classroom.
  def current_classroom
    if current_user.is_a?(Parent)
      @current_classroom ||= current_child.classroom
    elsif current_user.is_a?(Teacher) || current_user.is_a?(SchoolManager)
      @current_classroom ||= current_user.current_classroom
    else
      ### TODO: Expection => No Parent/Teacher/SchoolManager User.
    end
  end

  # Public: Helper method to get current child.
  #
  # Returns a Child.
  def current_child
    if current_user.parent?
      @current_child ||= current_user.current_child
    else
      ### TODO: Expection => Only Parents have Children.
    end
  end

end