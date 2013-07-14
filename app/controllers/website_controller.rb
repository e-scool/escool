class WebsiteController < ApplicationController

  before_filter :set_website_locale, only: [:index]

  respond_to :json, only: [:contact]

  def index
    @support_message = SupportMessage.new
    render :layout => "website"
  end

  def contact
    @support_message = SupportMessage.new(params[:support_message])
    if @support_message.valid? && WebsiteMailer.contact_email(@support_message).deliver
      @message_sent = true
    else
      @message_sent = false    
    end
    respond_with @message_sent.to_json
  end
end
