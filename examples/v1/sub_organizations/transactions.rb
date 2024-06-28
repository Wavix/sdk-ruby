# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

sub_transactions_attrs = { from_date: '2021-01-01', to_date: '2024-01-01', id: 100_657 }

# Use full version
WavixApi::V1::SubOrganizations::Transactions.new(sub_transactions_attrs).call

# Or short version
WavixApi::V1::SubOrganizations::Transactions.call(sub_transactions_attrs)
