require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ShoeStoreApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks))

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    # Configuration for code generators.
    config.generators do |g|
      g.template_engine nil
      g.test_framework :rspec, fixture: false
      g.stylesheets false
      g.javascripts false
      g.helper false
      g.api true
    end

    # Configures Redis as the cache store using the Redis URL specified in the environment variables.
    config.cache_store = :redis_cache_store, { url: ENV['REDIS_URL'] }

    # Sets Sidekiq as the queue adapter for Active Job, enabling background job processing with Sidekiq.
    config.active_job.queue_adapter = :sidekiq

    # Disables request forgery protection for Action Cable, allowing connections from any origin.
    config.action_cable.disable_request_forgery_protection = true

    # Allows WebSocket connections from any origin.
    config.action_cable.allowed_request_origins = [ '*' ]
  end
end
