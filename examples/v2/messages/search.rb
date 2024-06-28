# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

attrs = { type: 'outbound', sent_after: '2021-08-01', sent_before: '2025-08-01' }

# Use full version
WavixApi::V2::Messages::Search.new(attrs).call

# Or short version
WavixApi::V2::Messages::Search.call(attrs)
