class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def set_website_locale
    I18n.locale = params[:lang] if %w(es ca).include?(params[:lang])
  end
end
