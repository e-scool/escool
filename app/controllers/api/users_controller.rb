class Api::UsersController < Api::BaseController

  # GET /api/users?ids=[1,2,3]
  def index
    if params[:ids].kind_of?(Array)
      @users = User.where(id: params[:ids]).becomes(User)
    end
  end

  def show
    user = User.find(params[:id])
    type = user.type

    if user == current_user
      @user = user.becomes(User)
      @user.type = type
    end
  end
end
