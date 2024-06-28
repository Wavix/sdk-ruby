# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

ids_attrs = { ids: [98] }
dids_attrs = { dids: ['12345678910'] }

# Use full version
WavixApi::V1::Mydids::Destroy.new(ids_attrs).call

# Or by dids

WavixApi::V1::Mydids::Destroy.new(dids_attrs).call

# Or short version
WavixApi::V1::Mydids::Destroy.call(ids_attrs)

# Or by dids
WavixApi::V1::Mydids::Destroy.call(dids_attrs)
