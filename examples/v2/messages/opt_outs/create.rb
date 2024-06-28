# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

attrs = { number: '12345678910', sender_id: 'sender1' }

# Use full version
WavixApi::V2::Messages::OptOuts::Create.new(attrs).call

# Or short version
WavixApi::V2::Messages::OptOuts::Create.call(attrs)
