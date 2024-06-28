# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

filters = { phone_number: '12345678910' }

# Use full version without filters
WavixApi::V1::E911Records::Search.new.call

# Or with filters
WavixApi::V1::E911Records::Search.new(filters).call

# Or short version without filters
WavixApi::V1::E911Records::Search.call

# Or with filters
WavixApi::V1::E911Records::Search.call(filters)
