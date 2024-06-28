# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

attrs = { id: 'uuid', sms_id: 'sms_uuid', format: 'jpg' }

# Use full version
WavixApi::V2::Messages::Attachments::Search.new(attrs).call

# Or short version
WavixApi::V2::Messages::Attachments::Search.call(attrs)
