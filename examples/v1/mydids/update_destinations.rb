# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

dst_attrs = {
  dids: '12345678910',
  sms_relay_url: 'http://sms_relay_url.com',
  destinations: [{ destination: '56947', priority: 1, transport: 5, trunk_id: 144 }]
}

# Use full version
WavixApi::V1::Mydids::UpdateDestinations.new(dst_attrs).call

# Or short version
WavixApi::V1::Mydids::UpdateDestinations.call(dst_attrs)
