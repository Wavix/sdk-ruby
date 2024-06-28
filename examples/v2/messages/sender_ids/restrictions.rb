# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

filters = { country: 'AW', type: 'alphanumeric' }

# Use full version
WavixApi::V2::Messages::SenderIds::Restrictions.new(filters).call

# Or short version
WavixApi::V2::Messages::SenderIds::Restrictions.call(filters)
