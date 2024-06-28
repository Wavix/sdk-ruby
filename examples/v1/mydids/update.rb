# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

update_attrs = {
  id: 97,
  call_recording_enabled: false,
  transcription_enabled: true,
  transcription_threshold: 12
}

# Use full version
WavixApi::V1::Mydids::Update.new(update_attrs).call

# Or short version
WavixApi::V1::Mydids::Update.call(update_attrs)
