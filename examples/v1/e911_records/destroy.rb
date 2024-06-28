# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

destroy_attrs = { phone_number: '12345678910' }

# Use full version
WavixApi::V1::E911Records::Destroy.new(destroy_attrs).call

# Or short version
WavixApi::V1::E911Records::Destroy.call(destroy_attrs)
