CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
      :provider => 'AWS',
      :aws_access_key_id => 'AKIAJF47SUXHK2TWKI3Q',
      :aws_secret_access_key => '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',
      :region => 'us-west-2'
  }

  config.fog_attributes ={
      :cache_control => 'max-age=315576000', :expires => 1.year.from_now.httpdate
  }

  if Rails.env.test? or Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = false
  else
    config.storage = :fog
  end


  config.fog_directory = "dteam-bucket-1"
  config.fog_public = false
end

