CarrierWave.configure do |config|
  config.cache_dir = "#{Rails.root}/tmp/uploads"

  # google_storage_access_key_id AKA x-goog-project-id
  # google_storage_secret_access_key AKA Google Cloud Storage ID
  config.fog_credentials = {
    :provider                         => 'Google',
    :google_storage_access_key_id     => ENV['GOOGLE_KEY'],
    :google_storage_secret_access_key => ENV['GOOGLE_SECRET']
  }
  config.fog_directory = ENV['FOG_DIRECTORY'] # AKA bucket name
end