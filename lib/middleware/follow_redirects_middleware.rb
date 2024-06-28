# frozen_string_literal: true

require 'faraday'
class FollowRedirectsMiddleware < Faraday::Middleware
  REDIRECT_CODES = [301, 302, 303, 307, 308].freeze

  def call(env)
    @app.call(env).on_complete do |response_env|
      if REDIRECT_CODES.include?(response_env.status)
        env.url = URI.parse(response_env[:response_headers]['location'])
        @app.call(env)
      end
    end
  end
end
