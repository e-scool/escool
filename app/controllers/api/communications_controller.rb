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
    @communication = if current_user.parent?
                       current_child.communications.create(create_params)
                     else
                       current_classroom.communications.create(create_params)
                     end

    if @communication.valid?
      render status: :created
    else
      render json: @communication.errors, status: :unprocessable_entity
    end
  end

  # def update
  #   respond_with current_classroom.communications.update(params[:id], params[:communication])
  # end

  # def destroy
  #   respond_with current_classroom.communications.destroy(params[:id])
  # end

  private

  def create_params
    params.require(:communication).permit(*create_params_group)
  end

  # def update_params
  #   params.require(:communication).permit(*(create_params_group | update_params_group))
  # end

  def create_params_group
    [
      :date,
      :title,
      :body
    ]
  end
end