class Api::ClassroomsController < Api::BaseController
  before_filter :current_user_is_not_parent

  def index
    @classrooms = current_user.classrooms
  end
end