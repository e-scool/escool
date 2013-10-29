class Api::CommunicationsController < Api::BaseController

  def index
    if current_user.parent?
      @communications = current_child.communications
    else
      @communications = current_classroom.communications
    end
  end

  def show
    if current_user.parent?
      @communication = current_child.communications.find(params[:id])
    else
      @communication = current_classroom.communications.find(params[:id])
    end
  end

  def create
    return if current_user.parent?
    respond_with current_classroom.communications.create(params[:communication])
  end

  def update
    return if current_user.parent?
    respond_with current_classroom.communications.update(params[:id], params[:communication])
  end

  def destroy
    return if current_user.parent?
    respond_with current_classroom.communications.destroy(params[:id])
  end

end