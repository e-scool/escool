class DashboardController < ApplicationController

  before_filter :authenticate_user!
  before_filter :set_current_data, :if => :authenticate_user!
  before_filter :get_data
  before_filter :redirect_if_current_user_is_parent?, :only => [:update_current_classroom]
  before_filter :redirect_if_current_user_is_not_parent?, :only => [:update_current_child]

  def index
    if current_user.parent?
      @classroom.communications.joins(:children).where("children_communications.child_id = ?", @child.id).order("date DESC").first
      @material = @classroom.materials.joins(:children).where("children_materials.child_id = ? AND date > ?", @child.id, Date.yesterday).order("date ASC").first
    else
      @communication = @classroom.communications.order("date DESC").first
      @material = @classroom.materials.where("date > ?", Date.yesterday).order("date ASC").first
    end
  end

  def docents

  end

  def update_current_child
    if current_user.children.select(:id).map{|i| i.id}.include?(params[:child_id].to_i)
      current_user.current_child_id = params[:child_id].to_i
      current_user.save
    end
    redirect_to dashboard_path
  end

  def update_current_classroom
    if current_user.classrooms.select(:id).map{|i| i.id}.include?(params[:classroom_id].to_i)
      current_user.current_classroom_id = params[:classroom_id].to_i
      current_user.save
    end
    redirect_to dashboard_path
  end
end

