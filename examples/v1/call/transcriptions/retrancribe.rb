# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

attrs = {
  cdr_id: 'uuid',
  language: 'en',
  webhook_url: 'your.site.com/path/to/webhook'
}

# Use full version
WavixApi::V1::Call::Transcriptions::Retranscribe.new(attrs).call

# Or short version
WavixApi::V1::Call::Transcriptions::Retranscribe.call(attrs)
