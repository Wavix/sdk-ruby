# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

countries_search_attrs = { type_filter: '', text_enabled_only: false }

# Use full version
WavixApi::V1::Buy::Countries::Search.new(countries_search_attrs).call

# Or short version
WavixApi::V1::Buy::Countries::Search.call(countries_search_attrs)
