CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => ENV['S3_KEY'],       # required
    :aws_secret_access_key  => ENV['S3_SECRET'],       # required
  }

  # TODO: point to a different bucket
  config.fog_directory  = 'ken-mazaika-music-dev'                     # required
  
end
