class Api::MaterialsController < Api::BaseController
  before_filter :current_user_is_not_parent, only: [:create, :update, :destroy]

  def index
    @materials = if current_user.parent?
                   current_child.materials
                 else
                   current_classroom.materials
                 end
  end

  def show
    @material = if current_user.parent?
                  current_child.materials.find(params[:id])
                else
                  current_classroom.materials.find(params[:id])
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