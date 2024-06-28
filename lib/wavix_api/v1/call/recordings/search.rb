# frozen_string_literal: true

module WavixApi
  module V1
    module Call
      module Recordings
        class Search
          include WavixApi::BaseMethods

          DATE_FIELDS = %i[from_date to_date].freeze
          DATETIME_FIELDS = %i[from_time to_time].freeze
          DATE_FORMAT = '%Y.%m.%d'
          DATETIME_FORMAT = '%Y.%m.%dTT%H:%M:%S.000'

          @params_schema = {
            type: 'object',
            properties: {
              from: { type: 'string', pattern: ::WavixApi::BaseMethods::ONLY_DIGITS_REGEXP }.freeze,
              to: { type: 'string', pattern: ::WavixApi::BaseMethods::ONLY_DIGITS_REGEXP }.freeze,
              call_uuid: { type: 'string' }.freeze,
              sip_trunks: {
                type: 'array',
                items: { type: 'string' }.freeze
              }.freeze,
              dids: {
                type: 'array',
                items: {
                  type: 'string',
                  pattern: ::WavixApi::BaseMethods::ONLY_DIGITS_REGEXP
                }.freeze
              }.freeze
            }.freeze
          }.freeze

          class << self
            def call(params = {})
              instance = new(params)

              instance.validate!
              instance.validate_dates!(DATE_FIELDS + DATETIME_FIELDS)

              instance.stringify_dates!(
                instance.params, fields: DATE_FIELDS, format: DATE_FORMAT
              )
              instance.stringify_dates!(
                instance.params, fields: DATETIME_FIELDS, format: DATETIME_FORMAT
              )
              instance.get('v1/recordings')
            end
          end
        end
      end
    end
  end
end
