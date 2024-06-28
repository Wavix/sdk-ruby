# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

profile_attrs = {
  timezone: 'UTC',
  contact_email: 'some@email.com',
  additional_info: 'dev',
  attn_contact_name: 'wavix',
  billing_address: 'wavix in the house',
  company_name: 'wavix',
  first_name: 'First',
  last_name: 'Last',
  phone: '12345678910'
}

# Use full version
WavixApi::V1::Profile::Update.new(profile_attrs).call

# Or short version
WavixApi::V1::Profile::Update.call(profile_attrs)
