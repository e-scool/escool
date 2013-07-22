class Api::ChildrenController < ApplicationController

  respond_to :json

  before_filter :authenticate_user!

  def index
    if current_user.parent?
      @children = current_user.children.all
    else
      render status: 404, json: {message: 'Invalid token.'}
    end
  end
end