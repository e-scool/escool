class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_child,
                :current_classroom

  # Public: Check if current_user has current_child (if is a Parent) or
  # current_classroom (if is a Teacher or SchoolManager).
  #
  # Returns True/False.
  def child_or_classroom_assigned?
    current_user.has_child_or_classroom_assigned?
  end

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

  private

  # Private: Set website locale if params[:lang] is a correct locale.
  #
  # Returns nothing.
  def set_website_locale
    app_locales = %w(es ca)
    I18n.locale = params[:lang] if app_locales.include?(params[:lang])
  end

  # Private: Add current_child (if current_user is a Parent) or current_classroom
  # (if current_user is a Teacher or SchoolManager) to current_user.
  #
  # Returns True/False.
  def set_current_data
    if current_user.parent?
      current_user.add_current_child
    elsif current_user.teacher? || current_user.school_manager?
      current_user.add_current_classroom
    else
      ### TODO: Expection => No Parent/Teacher/SchoolManager User.
      return false
    end
    return true
  end

  def redirect_if_current_user_is_parent?
    redirect_to dashboard_path if current_user.parent?
  end

  def redirect_if_current_user_is_not_parent?
    redirect_to dashboard_path unless current_user.parent?
  end

  def redirect_if_current_user_is_teacher?
    redirect_to dashboard_path if current_user.teacher?
  end

  def redirect_if_current_user_is_not_teacher?
    redirect_to dashboard_path unless current_user.teacher?
  end

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def after_sign_out_path_for(resource)
    login_path
  end
end