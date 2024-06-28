# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

attrs = { status: 'enabled' }

# Use full version
WavixApi::V1::SubOrganizations::Search.new(attrs).call

# Or short version
WavixApi::V1::SubOrganizations::Search.call(attrs)
