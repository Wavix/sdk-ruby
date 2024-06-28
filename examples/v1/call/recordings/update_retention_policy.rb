# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

update_ret_policy_attrs = { settings: { recording_store_months: 36 } }

# Use full version
WavixApi::V1::Call::Recordings::UpdateRetentionPolicy.new(update_ret_policy_attrs).call

# Or short version
WavixApi::V1::Call::Recordings::UpdateRetentionPolicy.call(update_ret_policy_attrs)
