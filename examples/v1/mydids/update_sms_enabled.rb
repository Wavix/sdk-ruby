# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

attrs = { sms_enabled: false, id: 97 }

# Use full version
WavixApi::V1::Mydids::UpdateSmsEnabled.new(attrs).call

# Or short version
WavixApi::V1::Mydids::UpdateSmsEnabled.call(attrs)
