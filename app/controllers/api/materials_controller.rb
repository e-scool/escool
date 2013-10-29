class Api::MaterialsController < Api::BaseController

  def index
    if current_user.parent?
      @materials = current_child.materials
    else
      @materials = current_classroom.materials
    end
  end

  def show
    if current_user.parent?
      @material = current_child.materials.find(params[:id])
    else
      @material = current_classroom.materials.find(params[:id])
    end
  end

  def create
    return if current_user.parent?
    respond_with current_classroom.materials.create(params[:material])
  end

  def update
    return if current_user.parent?
    respond_with current_classroom.materials.update(params[:id], params[:material])
  end

  def destroy
    return if current_user.parent?
    respond_with current_classroom.materials.destroy(params[:id])
  end

end