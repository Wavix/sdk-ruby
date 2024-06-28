# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

tactions_search = {
  type: 1,
  from_date: '2021-01-01',
  to_date: '2024-12-12',
  payments: true,
  details_contains: 'hello'
}

# Use full version
WavixApi::V1::Billing::Transactions::Search.new(tactions_search).call

# Or short version
WavixApi::V1::Billing::Transactions::Search.call(tactions_search)
