module Api
  class CommunicationsController < ApplicationController
    class Communication < ::Communication
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
        respond_with @child.communications.all, :include => :subject
      else
        respond_with @classroom.communications.all, :include => [:subject, :children]
      end
    end

    def show
      respond_with @classroom.communications.find(params[:id])
    end

    def create
      respond_with @classroom.communications.create(params[:communication])
    end

    def update
      respond_with @classroom.communications.update(params[:id], params[:communication])
    end

    def destroy
      respond_with @classroom.communications.destroy(params[:id])
    end
  end
end