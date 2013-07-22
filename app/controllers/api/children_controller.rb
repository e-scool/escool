module Api
  class ChildrenController < ApplicationController
    class Child < ::Child
      def as_json(options = {})
        super
      end
    end

    respond_to :json

    before_filter :authenticate_user!

    def index
      if current_user.parent?
        respond_with current_user.children.all, :include => :classroom
      else
        render status: 404, json: {message: 'Invalid token.'}
      end
    end
  end
end