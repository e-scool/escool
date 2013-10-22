class Api::ChildrenController < Api::BaseController

  def index
    if current_user.parent?
      @children = current_user.children.all
    else
      render status: 404, json: {message: 'Invalid token.'}
    end
  end

end