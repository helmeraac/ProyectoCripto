require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Citopat
  class Application < Rails::Application
    config.i18n.default_locale = 'es-CO'
    config.action_mailer.preview_path = "#{Rails.root}/spec/mailer_previews"
    config.time_zone = 'America/Bogota'
    config.active_record.time_zone_aware_types = [:datetime]
    config.autoload_paths += %W["#{config.root}/app/validators/"]
    config.fog_host = "https://s3-us-west-2.amazonaws.com/dteam-bucket-1/"
    # Settings in config/environmesnts/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
