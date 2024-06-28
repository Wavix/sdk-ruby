# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

attrs = {
  label: 'Hello',
  callerid: '12345678910',
  ip_restrict: false,
  didinfo_enabled: true,
  call_restrict: false,
  call_limit: 999,
  cost_limit: false,
  max_call_cost: 33.3,
  channels_restrict: false,
  max_channels: 1,
  rewrite_enabled: false,
  rewrite_prefix: '',
  rewrite_cond: '',
  transcription_enabled: false,
  transcription_threshold: 6,
  password: 'SomePass',
  multiple_numbers: false,
  call_recording_enabled: false,
  machine_detection_enabled: false
}

# Use full version
WavixApi::V1::Trunks::Create.new(attrs).call

# Or short version
WavixApi::V1::Trunks::Create.call(attrs)
