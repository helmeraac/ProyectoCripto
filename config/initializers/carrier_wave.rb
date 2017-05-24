CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
      :provider => 'AWS',
      :aws_access_key_id => 'AKIAI7XTYFSJWBQYFUJQ',
      :aws_secret_access_key => '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',
      :region => 'us-west-2'
  }

  config.fog_attributes ={
      :cache_control => 'max-age=315576000', :expires => 1.year.from_now.httpdate
  }

  if Rails.env.test? || Rails.env.cucumber? || Rails.env.development?
    config.storage = :file
    config.enable_processing = false
  else
    config.storage = :fog
  end


  config.fog_directory = "dteam-bucket-1"
  config.fog_public = false
end

