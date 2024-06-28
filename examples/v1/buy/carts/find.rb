# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

# Use full version
WavixApi::V1::Buy::Carts::Find.new.call

# Or short version
WavixApi::V1::Buy::Carts::Find.call
