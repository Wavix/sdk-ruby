# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

attrs = {
  from: '12345678910',
  to: '10987654321',
  message_body: { text: 'hi', media: 'https://www.some.com/test.jpg' }
}

# Use full version
WavixApi::V2::Messages::Create.new(attrs).call

# Or short version
WavixApi::V2::Messages::Create.call(attrs)
