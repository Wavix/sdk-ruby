# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

search_attrs = { search: 'Poland', label_present: false }

# Use full version
WavixApi::V1::Mydids::Search.new(search_attrs).call

# Or short version
WavixApi::V1::Mydids::Search.call(search_attrs)
