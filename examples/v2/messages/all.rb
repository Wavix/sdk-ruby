# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

filters = { type: 'outbound', sent_after: '2021-08-01', sent_before: '2025-08-01' }

# Use full version
WavixApi::V2::Messages::All.new(filters).call

# Or short version
WavixApi::V2::Messages::All.call(filters)
