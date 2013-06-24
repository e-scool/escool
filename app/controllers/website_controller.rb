class WebsiteController < ApplicationController

  before_filter :set_website_locale

  def index
    @support_message = SupportMessage.new
    render :layout => "website"
  end

  def contact
    @support_message = SupportMessage.new(params[:support_message])

    if @support_message.valid?
      WebsiteMailer.contact_email(@support_message).deliver
      puts "*****************"
      puts "*****************"
      puts "*****************"
      puts "valid"
      puts "*****************"
      puts "*****************"
      puts "*****************"
      #
      # TODO: Ha de responder con Json!!
      #
      redirect_to(root_path, :notice => "Message was successfully sent.")
    else
      flash.now.alert = "Please fill all fields."
      puts "*****************"
      puts "*****************"
      puts "*****************"
      puts "No valid"
      puts "*****************"
      puts "*****************"
      puts "*****************"
      #
      # TODO: Ha de responder con Json!!
      #
      render :index
    end
  end
end
