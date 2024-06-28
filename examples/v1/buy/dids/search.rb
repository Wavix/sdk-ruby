# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

dids_search_attrs = {
  type_filter: '',
  text_enabled_only: false,
  country_id: 123,
  city_id: 1234
}
# Use full version
WavixApi::V1::Buy::Dids::Search.new(dids_search_attrs).call

# Or short version
WavixApi::V1::Buy::Dids::Search.call(dids_search_attrs)
