# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

update_rec_settings_attrs = {
  recording: {
    new_state: true, sip_trunks: ['569'], dids: ['12345678910']
  }
}

# Use full version
WavixApi::V1::Call::Recordings::UpdateRecordingSettings.new(update_rec_settings_attrs).call

# Or short version
WavixApi::V1::Call::Recordings::UpdateRecordingSettings.call(update_rec_settings_attrs)
