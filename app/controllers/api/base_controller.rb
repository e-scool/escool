class Api::BaseController < ActionController::Base
  before_filter :authenticate_user!

  respond_to :json

  helper_method :current_child,
                :current_classroom

  # Public: Helper method to get current classroom.
  #
  # Returns a Classroom.
  def current_classroom
    if %w(Parent Teacher SchoolManager).include?(current_user.type)
      @current_classroom ||= get_current_classroom
    else
      ### TODO: Expection => No Parent/Teacher/SchoolManager User.
    end
  end

  # Public: Helper method to get current child.
  #
  # Returns a Child.
  def current_child
    if current_user.parent?
      @current_child ||= get_current_child
    else
      ### TODO: Expection => Only Parents have Children.
    end
  end

  private

  def get_current_child
    return current_user.children.find(params[:child_id]) if params[:child_id]
    current_user.current_child
  end

  def get_current_classroom
    return current_user.current_child.classroom if current_user.parent?
    return current_user.classrooms.find(params[:classroom_id]) if params[:classroom_id]
    current_user.current_classroom
  end

  # Public: Before filter used to block some actions to non-Parents.
  #
  # Returns nothing.
  def current_user_is_parent
    return head :unprocessable_entity unless current_user.parent?
  end

  # Public: Before filter used to block some actions to Parents.
  #
  # Returns nothing.
  def current_user_is_not_parent
    return head :unprocessable_entity if current_user.parent?
  end
end