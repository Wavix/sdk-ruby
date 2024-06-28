# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

# Use full version
WavixApi::V2::Messages::Find.new(id: 'uuid').call

# Or short version
WavixApi::V2::Messages::Find.call('uuid')
