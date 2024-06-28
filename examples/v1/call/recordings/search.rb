# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

recordings_attrs = {
  dids: ['12345678910'],
  call_uuid: 'call_uuid',
  from_date: '2021.01.01',
  to_date: '2024.01.01'
}

# Use full version without filters
WavixApi::V1::Call::Recordings::Search.new.call

# Or with filters
WavixApi::V1::Call::Recordings::Search.new(recordings_attrs).call

# Or short version without filters
WavixApi::V1::Call::Recordings::Search.call

# Or with filters
WavixApi::V1::Call::Recordings::Search.call(recordings_attrs)
