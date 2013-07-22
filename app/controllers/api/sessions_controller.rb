module Api
  class SessionsController < ApplicationController
    skip_before_filter :verify_authenticity_token

    respond_to :json

    def create
      login = params[:login]
      password = params[:password]
 
      if login.nil? or password.nil?
         render status: 400, json: {message: 'The request must contain the user email and password.'}
         return
      end
   
      @user = User.find_first_by_auth_conditions(login: login)
   
      if @user.nil?
        logger.info("User #{login} failed signin, user cannot be found.")
        render status: 401, json: {message: 'Invalid email or passoword.'}
        return
      end
   
      # http://rdoc.info/github/plataformatec/devise/master/Devise/Models/TokenAuthenticatable
      @user.ensure_authentication_token!
   
      if not @user.valid_password?(password)
        logger.info("User #{login} failed signin, password \"#{password}\" is invalid")
        render status: 401, json: {message: 'Invalid email or password.'}
      else
        render status: 200, json: {token: @user.authentication_token}
      end
    end
 
    def destroy
      @user = User.find_by_authentication_token(params[:id])
      if @user.nil?
        logger.info('Token not found.')
        render status: 404, json: {message: 'Invalid token.'}
      else
        @user.reset_authentication_token!
        render status: 200, json: {token: params[:id]}
      end
    end
  end
end