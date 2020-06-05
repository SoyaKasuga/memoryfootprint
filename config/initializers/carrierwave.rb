require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'
unless Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Rails.application.credentials.aws[:access_key_id],
      aws_secret_access_key: Rails.application.credentials.aws[:secret_access_key],
      region: 'ap-northeast-1'
    }
    config.fog_provider = 'fog/aws'
    config.fog_directory  = 'memoryfootbucket'
    config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/memoryfootbucket'
  end
end
CarrierWave::SanitizedFile.sanitize_regexp = /[^[:print:]]/