class ApplicationController < ActionController::Base
  protect_from_forgery

  def child_or_classroom_assigned?
    current_user.has_child_or_classroom_assigned?
  end

  private

  def set_website_locale
    I18n.locale = params[:lang] if %w(es ca).include?(params[:lang])
  end

  def set_current_data
    if current_user.parent?
      current_user.add_current_child
    elsif current_user.teacher? || current_user.school_manager?
      current_user.add_current_classroom
    else
      ##
      ## Expection => No Parent/Teacher/SchoolManager User
      ##
    end
  end

  def get_data
    if current_user.parent?
      @classroom = current_user.current_child.classroom
      @child = current_user.current_child
    elsif current_user.teacher? || current_user.school_manager?
      @classroom = current_user.current_classroom
    else
      ##
      ## Expection => No Parent/Teacher/SchoolManager User
      ##
    end
  end

  def redirect_if_current_user_is_parent?
    redirect_to dashboard_path if current_user.parent?
  end

  def redirect_if_current_user_is_not_parent?
    redirect_to dashboard_path unless current_user.parent?
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
