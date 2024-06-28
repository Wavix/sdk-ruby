# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

attrs = { type: 'alphanumeric', sender_id: 'sender1', countries: ['AW'] }

# Use full version
WavixApi::V2::Messages::SenderIds::Create.new(attrs).call

# Or short version
WavixApi::V2::Messages::SenderIds::Create.call(attrs)
