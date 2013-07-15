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
      sent = "sent"
    else
      sent = "no_sent"
    end

    title    = t "website.contact_form_response_messages.#{sent}.title"
    text     = t "website.contact_form_response_messages.#{sent}.text"
    response = { title: title, text: text }

    respond_with response.to_json
  end
end
