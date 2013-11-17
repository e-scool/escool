class Api::ClassroomsController < Api::BaseController

  def index
    @classrooms = current_user.classrooms unless current_user.parent?
  end

end