class Api::ChildrenController < Api::BaseController
  before_filter :current_user_is_parent

  def index
    @children = current_user.children
  end
end