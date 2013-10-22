class Api::UsersController < Api::BaseController

  # GET /api/users?ids=[1,2,3]
  def index
    if params[:ids].kind_of?(Array)
      @users = User.where(id: params[:ids]).becomes(User).decorate
    end
  end

  def show
    @user = User.find(params[:id]).becomes(User).decorate
  end

end
