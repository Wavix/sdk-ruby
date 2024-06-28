# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

sub_transactions_update_attrs = {
  name: 'hello from ruby sdk',
  status: 'active',
  default_destinations: {
    sms_endpoint: 'https://sms_endpoint.com', dlr_endpoint: 'https://dlr_endpoint.com'
  },
  id: 100_657
}

# Use full version
WavixApi::V1::SubOrganizations::Update.new(sub_transactions_update_attrs).call

# Or short version
WavixApi::V1::SubOrganizations::Update.call(sub_transactions_update_attrs)
