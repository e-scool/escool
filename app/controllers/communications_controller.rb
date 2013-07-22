class CommunicationsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :set_current_data, unless: :child_or_classroom_assigned?

  def index

  end

end