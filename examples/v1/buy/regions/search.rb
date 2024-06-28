# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

regions_search_attrs = { country_id: 123, type_filter: '', text_enabled_only: false }

# Use full version
WavixApi::V1::Buy::Regions::Search.new(regions_search_attrs).call

# Or short version
WavixApi::V1::Buy::Regions::Search.call(regions_search_attrs)
