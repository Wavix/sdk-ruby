# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

cdr_advenced_attrs = {
  from: '2000-01-01',
  to: '2024-12-12',
  type: 'placed',
  transcription: {
    language: 'en',
    agent: { must: ['hello'], match: ['hey'], exclude: ['nope'] },
    lead: { must: ['help'], match: ['you'], exclude: ['close'] },
    any: { must: ['bye'], match: ['from'], exclude: ['start'] }
  }
}

# Use full version without filters
WavixApi::V1::Cdrs::AdvancedSearch.new.call

# Or with filters
WavixApi::V1::Cdrs::AdvancedSearch.new(cdr_advenced_attrs).call

# Or short version without filters
WavixApi::V1::Cdrs::AdvancedSearch.call

# Or filters
WavixApi::V1::Cdrs::AdvancedSearch.call(cdr_advenced_attrs)
