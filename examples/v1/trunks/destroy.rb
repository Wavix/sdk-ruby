# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

# Use full version
WavixApi::V1::Trunks::Destroy.new(id: 1283).call

# Or short version
WavixApi::V1::Trunks::Destroy.call(1283)
