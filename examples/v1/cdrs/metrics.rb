# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

metrics_attrs = { from: '2021-01-01', to: '2024-03-03' }

# Use full version without filters
WavixApi::V1::Cdrs::Metrics.new.call

# Or with filters
WavixApi::V1::Cdrs::Metrics.new(metrics_attrs).call

# Or short version without filters
WavixApi::V1::Cdrs::Metrics.call

# Or with filters
WavixApi::V1::Cdrs::Metrics.call(metrics_attrs)
