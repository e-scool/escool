class DashboardController < ApplicationController

  before_filter :authenticate_user!
  before_filter :set_current_data, only: [:index, :docents], unless: :child_or_classroom_assigned?

  before_filter :redirect_if_current_user_is_parent?, only: [:update_current_classroom]
  before_filter :redirect_if_current_user_is_not_parent?, only: [:update_current_child]

  def index
    if current_user.parent?
      @communication = current_classroom.communications.joins(:children).where("children_communications.child_id = ?", current_child.id).order("date DESC").first
      @material = current_classroom.materials.joins(:children).where("children_materials.child_id = ? AND date > ?", current_child.id, Date.yesterday).order("date ASC").first
    elsif current_user.teacher? || current_user.school_manager?
      @communication = current_classroom.communications.order("date DESC").first
      @material = current_classroom.materials.where("date > ?", Date.yesterday).order("date ASC").first
    else
      ##
      ## Expection => No Parent/Teacher/SchoolManager User
      ##
    end
  end

  def docents
  end

  def update_current_child
    if current_user.children.select(:id).map{|i| i.id}.include?(params[:child_id].to_i)
      current_user.update_attribute(:current_child, Classroom.find(params[:child_id]))
    end
    redirect_to dashboard_path
  end

  def update_current_classroom
    if current_user.classrooms.select(:id).map{|i| i.id}.include?(params[:classroom_id].to_i)
      current_user.update_attribute(:current_classroom, Classroom.find(params[:classroom_id]))
    end
    redirect_to dashboard_path
  end

end