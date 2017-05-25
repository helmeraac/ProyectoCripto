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

    config.action_dispatch.default_headers = {
        'X-Frame-Options' => 'SAMEORIGIN',
        'X-XSS-Protection' => '1',
        'Pragma' => 'no-cache',
        'Cache-Control' => 'must-revalidate, no-cache, no-store, private, max-age=0',
        'X-Content-Type-Options' => 'nosniff',
    }
    config.public_file_server.headers = {
        'X-Frame-Options' => 'SAMEORIGIN',
        'Cache-Control' => 'must-revalidate, no-cache, no-store, private, max-age=0',
        'Pragma' => 'no-cache',
        'X-XSS-Protection' => '1',
        'X-Content-Type-Options' => 'nosniff',
    }
    # config.action_dispatch.default_headers['Pragma'] = "no-cache"
    # config.action_dispatch.default_headers['Cache-Control'] = "must-revalidate, no-cache, no-store, private, max-age=0"
    # Settings in config/environmesnts/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
