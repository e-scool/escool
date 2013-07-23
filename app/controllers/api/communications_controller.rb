class Api::CommunicationsController < ApplicationController

  class Communication < ::Communication
    def as_json(options = {})
      super
    end
  end

  respond_to :json

  before_filter :authenticate_user!
  before_filter :set_current_data, unless: :child_or_classroom_assigned?
  before_filter :redirect_if_current_user_is_not_teacher?, only: [:create, :update, :destroy]

  def index
    if current_user.parent?
      child = current_user.children.find(params[:child_id])
      # respond_with child.communications.all, include: :subject
    else
      classroom = current_user.classrooms.find(params[:classroom_id])
      # respond_with classroom.communications.all, include: [:subject, :children]
    end
  end

  def show
    if current_user.parent?
      child = current_user.children.find(params[:child_id])
      # respond_with child.communications.find(params[:id])
    else
      classroom = current_user.classrooms.find(params[:classroom_id])
      # respond_with current_classroom.communications.find(params[:id])
    end
  end

  def create
    respond_with current_classroom.communications.create(params[:communication])
  end

  def update
    respond_with current_classroom.communications.update(params[:id], params[:communication])
  end

  def destroy
    respond_with current_classroom.communications.destroy(params[:id])
  end

end