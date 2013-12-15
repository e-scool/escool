class WebsiteController < ApplicationController
  respond_to :json, only: [:contact]

  before_filter :set_website_locale, only: [:index]

  def index
    @support_message = SupportMessage.new

    render layout: 'website'
  end

  def contact
    message = SupportMessage.new(params[:support_message])

    action = if message.valid? && WebsiteMailer.contact_email(message).deliver
               'sent'
             else
               'no_sent'
             end

    response = {
      title: t("website.contact_form_response_messages.#{action}.title"),
      text:  t("website.contact_form_response_messages.#{action}.text")
    }

    respond_with response.to_json
  end
end