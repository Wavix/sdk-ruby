# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

# Use full version
WavixApi::V3::Messages::SenderIds::Find.new(id: 'uuid').call

# Or short version
WavixApi::V3::Messages::SenderIds::Find.call('uuid')
