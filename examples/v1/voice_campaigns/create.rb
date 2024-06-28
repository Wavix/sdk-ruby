# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

attrs = {
  voice_campaign: {
    callflow_id: 340, contact: '44200000000', caller_id: '44210000000'
  }
}

# Use full version
WavixApi::V1::VoiceCampaigns::Create.new(attrs).call

# Or short version
WavixApi::V1::VoiceCampaigns::Create.call(attrs)
