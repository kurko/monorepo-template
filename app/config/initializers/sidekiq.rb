require "sidekiq/web"
Sidekiq::Web.session_secret = Rails.application.secrets[:secret_key_base]
Sidekiq::Web.sessions       = Rails.application.config.session_options
redis_url = ENV["REDIS_URL"] || (Rails.env.development? and "redis://localhost:6379/10")

Sidekiq.configure_server do |config|
  config.redis = { url: redis_url, network_timeout: 5 }
  Rails.logger = Sidekiq.logger
  #Sidekiq::ReliableFetch.setup_reliable_fetch!(config) unless Rails.env.test?
end

Sidekiq.configure_client do |config|
  config.redis = { url: redis_url, network_timeout: 5 }
end


# Monkey patching Sidekiq logs
module Sidekiq
  class JobLogger

    # For a perform method with args param1 and param2, this will append in the
    # logs,
    #
    # ...  args=(param1=a, param2=b) INFO: start
    #
    def job_hash_context(job_hash)
      # If we're using a wrapper class, like ActiveJob, use the "wrapped"
      # attribute to expose the underlying thing.
      hash = {
        class: job_hash["wrapped"] || job_hash["class"],
        jid: job_hash["jid"],
      }
      hash[:bid] = job_hash["bid"] if job_hash["bid"]
      hash[:tags] = job_hash["tags"] if job_hash["tags"]

      if job_hash["args"].present?
        parameters = hash[:class].constantize.new.method(:perform).parameters
        params_and_values = parameters.each_with_object([]) { |param_keys, params_and_values|
          value = job_hash["args"][params_and_values.count]

          # In case it's too long of a value, truncate it.
          value = "[omitted]" if value.to_s.size > 10

          params_and_values << "#{param_keys[1]}=#{value}"
          params_and_values
        }.join(", ")

        hash[:args] = "(#{params_and_values})"
      end

      hash
    end
  end
end
