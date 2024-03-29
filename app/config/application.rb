require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.generators do |g|
      g.view_specs false
      g.views false
      g.helpers_specs false
      g.helpers false
      g.stylesheets false
      g.javascripts false
      g.orm :active_record
    end

    config.active_job.queue_adapter = :sidekiq

    config.autoload_paths += %W[
      #{config.root}/app/workers
      #{config.root}/lib
    ]

    config.eager_load_paths += %W[
      #{config.root}/app/workers
      #{config.root}/lib
    ]

    config.react.server_renderer_extensions = ["jsx", "js", "tsx", "ts"]
  end
end
