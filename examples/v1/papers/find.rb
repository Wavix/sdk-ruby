# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

find_attrs = { mydid_id: 1017, doc_type_id: 2 }

# Use full version
WavixApi::V1::Papers::Find.new(find_attrs).call

# And with save_path dir
WavixApi::V1::Papers::Find.new(find_attrs.merge(save_path: 'path/to/')).call

# Or short version
WavixApi::V1::Papers::Find.call(find_attrs)
