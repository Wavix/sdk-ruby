# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

# Use full version
WavixApi::V1::Buy::Carts::Update.new(ids: '1,2').call

# Or short version
WavixApi::V1::Buy::Carts::Update.call(ids: '1,2')
