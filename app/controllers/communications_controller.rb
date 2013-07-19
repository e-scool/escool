class CommunicationsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :set_current_data, unless: :child_or_classroom_assigned?
  before_filter :get_data

  def index

  end

end