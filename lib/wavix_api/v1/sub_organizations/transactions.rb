# frozen_string_literal: true

require 'wavix_api'

module WavixApi
  module V1
    module SubOrganizations
      class Transactions
        include WavixApi::BaseMethods

        @params_schema = {
          type: 'object',
          properties: {
            type: { type: 'string' }.freeze,
            id: { type: 'integer' }.freeze,
            **::WavixApi::BaseMethods::PAGINATION_SCHEMA
          }.freeze,
          required: %i[id].freeze
        }.freeze

        class << self
          def call(params = {})
            instance = new(params)

            instance.validate!
            instance.validate_dates!(::WavixApi::V1::Cdrs::CommonVars::DATE_FIELDS)

            instance.stringify_dates!(
              instance.params, fields: ::WavixApi::V1::Cdrs::CommonVars::DATE_FIELDS
            )
            instance.get(
              ['v1/sub-organizations', instance.id, 'billing', 'transactions'].join('/')
            )
          end
        end
      end
    end
  end
end
