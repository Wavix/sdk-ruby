# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

# Use full version
WavixApi::V1::Profile::AccountConfig.new.call

# Or short version
WavixApi::V1::Profile::AccountConfig.call
