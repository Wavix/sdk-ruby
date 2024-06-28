# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

cdr_advenced_attrs = { from: '2000-01-01', to: '2024-12-12', type: 'placed' }

# Use full version without filters
WavixApi::V1::Cdrs::Search.new.call

# Or with filters
WavixApi::V1::Cdrs::Search.new(cdr_advenced_attrs).call

# Or short version without filters
WavixApi::V1::Cdrs::Search.call

# Or with filters
WavixApi::V1::Cdrs::Search.call(cdr_advenced_attrs)
