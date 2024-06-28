# frozen_string_literal: true

require 'wavix_api'

module WavixApi
  module V1
    module Billing
      module Transactions
        class Search
          include WavixApi::BaseMethods

          DATE_FIELDS = %i[from_date to_date].freeze

          @params_schema = {
            type: 'object',
            properties: {
              type: { type: 'integer' }.freeze,
              payments: { type: 'boolean' }.freeze,
              details_contains: { type: 'string' }.freeze,
              **::WavixApi::BaseMethods::PAGINATION_SCHEMA
            },
            required: DATE_FIELDS
          }.freeze

          class << self
            def call(params = {})
              instance = new(params)

              instance.validate!
              instance.validate_dates!(DATE_FIELDS)
              instance.stringify_dates!(instance.params, fields: DATE_FIELDS)
              instance.get('v1/billing/transactions')
            end
          end
        end
      end
    end
  end
end
