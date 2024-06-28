# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

# Use full version without filters
WavixApi::V1::Trunks::Search.new.call

# Or with filter
WavixApi::V1::Trunks::Search.new(per_page: 1).call

# Or short version without filters
WavixApi::V1::Trunks::Search.call

# Or with filter
WavixApi::V1::Trunks::Search.call(per_page: 1)
