# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

cities_search_attrs = {
  type_filter: '',
  text_enabled_only: false,
  country_id: 123,
  region_id: 1234
}

# Use full version
WavixApi::V1::Buy::Cities::Search.new(cities_search_attrs).call

# Or short version
WavixApi::V1::Buy::Cities::Search.call(cities_search_attrs)
