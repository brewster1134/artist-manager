class Settings < Settingslogic
  source "#{Rails.root}/config/settings.yml"
  namespace Rails.env
end
ArtistManager::Application.config.action_mailer.default_url_options = {host: Settings.host}
Money.default_currency = Settings.currency