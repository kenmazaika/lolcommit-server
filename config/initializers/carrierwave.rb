CarrierWave.configure do |config|
  unless Rails.env.test?
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV['S3_KEY'],
      :aws_secret_access_key  => ENV['S3_SECRET'],
    }

    config.fog_directory  = ENV['S3_BUCKET']
  end
end
