# frozen_string_literal: true

require 'wavix_api'

module WavixApi
  module V1
    module Profile
      class Update
        include WavixApi::BaseMethods

        @params_schema = {
          type: 'object',
          properties: {
            additional_info: { type: 'string' }.freeze,
            attn_contact_name: { type: 'string' }.freeze,
            billing_address: { type: 'string' }.freeze,
            contact_email: { type: 'string' }.freeze,
            default_short_link_endpoint: { type: 'string' }.freeze,
            first_name: { type: 'string' }.freeze,
            last_name: { type: 'string' }.freeze,
            phone: { type: 'string' }.freeze,
            sms_relay_url: { type: 'string' }.freeze,
            dlr_relay_url: { type: 'string' }.freeze,
            timezone: { type: 'string' }.freeze,
            job_title: { type: 'string' }.freeze,
            company_name: { type: 'string' }.freeze,
            company_address: { type: 'string' }.freeze,
            company_industry: { type: 'string' }.freeze,
            company_vat_number: { type: 'string' }.freeze,
            company_country_code: { type: 'string' }.freeze
          }.freeze,
          required: %i[
            additional_info
            attn_contact_name
            billing_address
            company_name
            contact_email
            first_name
            last_name
            phone
            timezone
          ].freeze,
          additionalProperties: false
        }.freeze

        class << self
          def call(params = {})
            instance = new(params)

            instance.validate!

            instance.patch('v1/profile')
          end
        end
      end
    end
  end
end
