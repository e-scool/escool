class DashboardController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_current_data, only: [:index], unless: :child_or_classroom_assigned?

  before_filter :redirect_if_current_user_is_parent?, only: [:update_current_classroom]
  before_filter :redirect_if_current_user_is_not_parent?, only: [:update_current_child]

  def index
  end

  #
  # Fixme: This should be remove from here and use Ember for that.
  #
  def update_current_child
    if current_user.children.pluck(:id).include?(params[:child_id].to_i)
      current_user.update_attribute(:current_child, Child.find(params[:child_id]))
    end

    redirect_to dashboard_path
  end

  #
  # Fixme: This should be remove from here and use Ember for that.
  #
  def update_current_classroom
    if current_user.classrooms.pluck(:id).include?(params[:classroom_id].to_i)
      current_user.update_attribute(:current_classroom, Classroom.find(params[:classroom_id]))
    end

    redirect_to dashboard_path
  end
end