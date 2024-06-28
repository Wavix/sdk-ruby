# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

sub_transactions_attrs = {
  name: 'hello from ruby sdk',
  status: 'active',
  default_destinations: {
    sms_endpoint: 'https://sms_endpoint.com', dlr_endpoint: 'https://dlr_endpoint.com'
  }
}

# Use full version
WavixApi::V1::SubOrganizations::Create.new(sub_transactions_attrs).call

# Or short version
WavixApi::V1::SubOrganizations::Create.call(sub_transactions_attrs)
