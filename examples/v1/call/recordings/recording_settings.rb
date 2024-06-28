# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

rec_settings = { sip_trunks: ['708'], dids: ['12345678910'] }

# Use full version without filters
WavixApi::V1::Call::Recordings::RecordingSettings.new.call

# OR with filters
WavixApi::V1::Call::Recordings::RecordingSettings.new(rec_settings).call

# Or short version without filters
WavixApi::V1::Call::Recordings::RecordingSettings.call

# OR with filters
WavixApi::V1::Call::Recordings::RecordingSettings.call(rec_settings)
