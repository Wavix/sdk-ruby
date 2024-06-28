# frozen_string_literal: true

require 'wavix_api'
require_relative 'common_vars'

module WavixApi
  module V1
    module Cdrs
      class Search
        include WavixApi::V1::Cdrs::CommonVars
        include WavixApi::BaseMethods

        @params_schema = {
          type: 'object',
          properties: ::WavixApi::V1::Cdrs::CommonVars::CDR_FIELDS_SCHEMA,
          required: ::WavixApi::V1::Cdrs::CommonVars::CDR_REQUIRED_FIELDS
        }.freeze

        class << self
          def call(params = {})
            instance = new(params)

            instance.validate!
            instance.validate_dates!(::WavixApi::V1::Cdrs::CommonVars::DATE_FIELDS)

            instance.stringify_dates!(
              instance.params, fields: ::WavixApi::V1::Cdrs::CommonVars::DATE_FIELDS
            )
            instance.get('v1/cdr')
          end
        end
      end
    end
  end
end
