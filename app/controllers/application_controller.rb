class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :set_locale

  private

  def default_url_options
    {locale: I18n.locale}
  end

  def set_locale
    # I18n.locale = params[:lang] || locale_from_header || I18n.default_locale
    I18n.locale = extract_locale || I18n.default_locale
  end

  def locale_from_header
    parsed_locale = request.env.fetch('HTTP_ACCEPT_LANGUAGE', '').scan(/[a-z]{2}/).first
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ?
      parsed_locale.to_sym :
      nil
  end

  def extract_locale
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ?
    parsed_locale.to_sym :
    nil
  end

end
