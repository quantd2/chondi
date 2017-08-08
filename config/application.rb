require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Chondi
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.i18n.default_locale = :vi
    config.action_controller.page_cache_directory = "#{Rails.root.to_s}/public/deploy"
    config.active_job.queue_adapter = :sidekiq
    config.active_record.schema_format = :sql

    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'prod_env.yml')
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value
      end if File.exists?(env_file)
    end
  end
end
