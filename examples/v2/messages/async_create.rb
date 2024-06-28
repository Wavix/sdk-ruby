# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

attrs = { from: '12345678910', to: '10987654321', message_body: { text: 'test', media: [] } }

# Use full version
WavixApi::V2::Messages::AsyncCreate.new(attrs).call

# Or short version
WavixApi::V2::Messages::AsyncCreate.call(attrs)
