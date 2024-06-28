# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

attrs = {
  type: 'alphanumeric',
  sender_id: 'sender1',
  countries: ['AW'],
  monthly_volume: '1-1000',
  samples: ['test'],
  usecase: 'promo'
}

# Use full version
WavixApi::V3::Messages::SenderIds::Create.new(attrs).call

# Or short version
WavixApi::V3::Messages::SenderIds::Create.call(attrs)
