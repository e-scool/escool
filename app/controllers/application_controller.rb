class ApplicationController < ActionController::Base
  protect_from_forgery

  #before_filter :session_inspect

  private

  #def session_inspect
  #  puts '***********************'
  #  puts '***********************'
  #  puts session.inspect
  #  puts '***********************'
  #  puts '***********************'
  #end

  def set_website_locale
    I18n.locale = params[:lang] if %w(es ca).include?(params[:lang])
  end

  def get_data
    if current_user.parent?
      @classroom = current_user.current_child.classroom
      @child = current_user.current_child
    elsif current_user.teacher? || current_user.school_manager?
      @classroom = current_user.current_classroom
    end
  end

  def set_current_data
    if current_user.parent?
      current_user.add_current_child unless current_user.current_child
    elsif current_user.teacher? || current_user.school_manager?
      current_user.add_current_classroom unless current_user.current_classroom
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
    #new_user_session_path
    login_path
  end
end
