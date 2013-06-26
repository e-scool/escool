class WebsiteMailer < ActionMailer::Base
  default from: "no-reply@e-scool.com"

  def contact_email(support_message)
    @message = support_message
    mail(:to => "info@e-scool.com", :subject => "Formulario de contacto e-scool.com")
  end
end
