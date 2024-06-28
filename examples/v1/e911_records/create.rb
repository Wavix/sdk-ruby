# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

create_attrs = {
  name: 'Test ruby sdk',
  phone_number: '12345678910',
  address: {
    street_number: '550',
    street: 'W Adams St',
    location: '2 floor',
    city: 'Chicago',
    state: 'Il',
    zip_code: '60661',
    zip_plus_four: '112'
  }
}

# Use full version
WavixApi::V1::E911Records::Create.new(create_attrs).call

# Or short version
WavixApi::V1::E911Records::Create.call(create_attrs)
