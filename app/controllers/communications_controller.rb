class CommunicationsController < ApplicationController

  respond_to :json, :html

  before_filter :authenticate_user!
  before_filter :set_current_data, :if => :authenticate_user!
  before_filter :get_data

  def index
    if current_user.parent?
      respond_with @child.communications.all, :include => :subject
    else
      respond_with @classroom.communications.all, :include => [:subject, :children]
    end
  end

end