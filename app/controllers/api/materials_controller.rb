class Api::MaterialsController < ApplicationController

  respond_to :json

  before_filter :authenticate_user!
  before_filter :set_current_data, unless: :child_or_classroom_assigned?
  before_filter :redirect_if_current_user_is_not_teacher?, only: [:create, :update, :destroy]

  def index
    if current_user.parent?
      child = current_user.children.find(params[:child_id])
      @materials = child.materials
    else
      classroom = current_user.classrooms.find(params[:classroom_id])
      @materials = classroom.materials
    end
  end

  def show
    if current_user.parent?
      child = current_user.children.find(params[:child_id])
      @material = child.materials.find(params[:id])
    else
      classroom = current_user.classrooms.find(params[:classroom_id])
      @material = classroom.materials.find(params[:id])
    end
  end

  def create
    respond_with current_classroom.materials.create(params[:material])
  end

  def update
    respond_with current_classroom.materials.update(params[:id], params[:material])
  end

  def destroy
    respond_with current_classroom.materials.destroy(params[:id])
  end

end