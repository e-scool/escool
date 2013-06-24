# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Escool::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => "app12818416@heroku.com",
  :password       => "38zxh2hz",
  :domain         => 'heroku.com',
  :enable_starttls_auto => true
}
