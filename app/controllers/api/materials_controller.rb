module Api
  class MaterialsController < ApplicationController
    class Material < ::Material
      def as_json(options = {})
        super
      end
    end

    respond_to :json

    before_filter :authenticate_user!
    before_filter :set_current_data, :if => :authenticate_user!
    before_filter :get_data
    before_filter :redirect_if_current_user_is_not_teacher?, :only => [:create, :update, :destroy]

    def index
      if current_user.parent?
        respond_with @child.materials.all, :include => :subject
      else
        respond_with @classroom.materials.all, :include => [:subject, :children]
      end
    end

    def show
      respond_with @classroom.materials.find(params[:id])
    end

    def create
      respond_with @classroom.materials.create(params[:material])
    end

    def update
      respond_with @classroom.materials.update(params[:id], params[:material])
    end

    def destroy
      respond_with @classroom.materials.destroy(params[:id])
    end
  end
end