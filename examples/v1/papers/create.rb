# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

create_attrs = { did_ids: '1017', doc_id: 2, doc_attachment: File.open('test.jpg') }

# Use full version
WavixApi::V1::Papers::Create.new(create_attrs).call

# Or short version
WavixApi::V1::Papers::Create.call(create_attrs)
