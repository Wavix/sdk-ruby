# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

attrs = { month: 12, year: 2023 }

# Use full version
WavixApi::V1::Call::Recordings::MonthStatistics::Search.new(attrs).call

# Or short version
WavixApi::V1::Call::Recordings::MonthStatistics::Search.call(attrs)
