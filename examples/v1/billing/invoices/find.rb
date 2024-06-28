# frozen_string_literal: true

require 'wavix-sdk-ruby'

WavixApi.host = 'api.wavix.com'
WavixApi.api_key = 'token'

# Use full version
WavixApi::V1::Billing::Invoices::Find.new(id: 4756).call

# You can save file from response to save_path
WavixApi::V1::Billing::Invoices::Find.new(id: 4756, save_path: 'some/path/invoice.pdf').call

# If you specify only folder it will be saved with default name
WavixApi::V1::Billing::Invoices::Find.new(id: 4756, save_path: 'some/path/').call

# Or short version
WavixApi::V1::Billing::Invoices::Find.call(id: 4756)

# And save file like this
WavixApi::V1::Billing::Invoices::Find.call(id: 4756, save_path: 'some/path/invoice.pdf')
