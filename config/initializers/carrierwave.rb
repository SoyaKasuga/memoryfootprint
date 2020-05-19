unless Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: 'AKIA2MWQQKK2D7DXQBSD',
      aws_secret_access_key: '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',
      region: 'ap-northeast-1'
    }

    config.fog_directory  = 'www.memoryfootprint.com'
    config.cache_storage = :fog
  end
end