class Api::CommunicationsController < Api::BaseController

  def index
    if current_user.parent?
      child = current_user.children.find(params[:child_id])
      @communications = child.communications
    else
      classroom = current_user.classrooms.find(params[:classroom_id])
      @communications = classroom.communications
    end
  end

  def show
    if current_user.parent?
      child = current_user.children.find(params[:child_id])
      @communication = child.communications.find(params[:id])
    else
      classroom = current_user.classrooms.find(params[:classroom_id])
      @communication = classroom.communications.find(params[:id])
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