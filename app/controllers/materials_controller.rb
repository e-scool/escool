class MaterialsController < ApplicationController

  respond_to :json, :html

  before_filter :authenticate_user!
  before_filter :set_current_data, :if => :authenticate_user!
  before_filter :get_data

  def index
    if current_user.parent?
      respond_with @child.materials.all, :include => :subject
    else
      respond_with @classroom.materials.all, :include => [:subject, :children]
    end
  end

end