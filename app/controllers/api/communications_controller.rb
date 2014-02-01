class Api::CommunicationsController < Api::BaseController
  before_filter :current_user_is_not_parent, only: [:create, :update, :destroy]

  def index
    @communications = if current_user.parent?
                        current_child.communications
                      else
                        current_classroom.communications
                      end
  end

  def show
    @communication = if current_user.parent?
                       current_child.communications.find(params[:id])
                     else
                       current_classroom.communications.find(params[:id])
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