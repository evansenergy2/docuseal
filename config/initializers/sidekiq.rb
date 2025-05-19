# frozen_string_literal: true

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_TLS_URL'] || 'redis://127.0.0.1:6379/0' }
end

require 'sidekiq/web' if defined?(Puma)

if !ENV['SIDEKIQ_BASIC_AUTH_PASSWORD'].to_s.empty? && defined?(Sidekiq::Web)
  Sidekiq::Web.use(Rack::Auth::Basic) do |_, password|
    ActiveSupport::SecurityUtils.secure_compare(
      Digest::SHA256.hexdigest(password),
      Digest::SHA256.hexdigest(ENV.fetch('SIDEKIQ_BASIC_AUTH_PASSWORD'))
    )
  end
end

Sidekiq.strict_args!
