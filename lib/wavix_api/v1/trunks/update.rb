# frozen_string_literal: true

module WavixApi
  module V1
    module Trunks
      class Update
        include WavixApi::BaseMethods

        @params_schema = {
          type: 'object',
          properties: {
            id: { type: 'integer' }.freeze,
            label: { type: 'string' }.freeze,
            password: { type: 'string' }.freeze,
            callerid: { type: 'string' }.freeze,
            ip_restrict: { type: 'boolean' }.freeze,
            didinfo_enabled: { type: 'boolean' }.freeze,
            call_restrict: { type: 'boolean' }.freeze,
            call_limit: { type: 'integer' }.freeze,
            cost_limit: { type: 'boolean' }.freeze,
            max_call_cost: { type: 'number' }.freeze,
            channels_restrict: { type: 'boolean' }.freeze,
            max_channels: { type: 'integer' }.freeze,
            rewrite_enabled: { type: 'boolean' }.freeze,
            rewrite_prefix: { type: 'string' }.freeze,
            rewrite_cond: { type: 'string' }.freeze,
            multiple_numbers: { type: 'boolean' }.freeze,
            allowed_ips: {
              type: 'array',
              items: {
                type: 'object',
                properties: {
                  id: { type: 'integer' }.freeze,
                  ip: {
                    type: 'string',
                    pattern: ::WavixApi::BaseMethods::IP_REGEXP
                  }.freeze,
                  _destroy: { type: 'boolean' }.freeze,
                  transcription_enabled: { type: 'boolean' }.freeze,
                  transcription_threshold: { type: 'integer' }.freeze
                }.freeze,
                required: %i[ip].freeze
              }
            }.freeze,
            host_request: {
              type: 'object',
              properties: {
                host: { type: 'string' }.freeze,
                status: { enum: %w[pending approved].freeze }.freeze
              }.freeze
            }.freeze,
            call_recording_enabled: { type: 'boolean' }.freeze,
            transcription_enabled: { type: 'boolean' }.freeze,
            transcription_threshold: { type: 'integer' }.freeze,
            machine_detection_enabled: { type: 'boolean' }.freeze
          }.freeze,
          required: %i[
            id
            label
            password
            callerid
            ip_restrict
            didinfo_enabled
            call_restrict
            cost_limit
            channels_restrict
            rewrite_enabled
            transcription_enabled
            transcription_threshold
          ].freeze
        }.freeze

        class << self
          def call(params = {})
            instance = new(params)

            instance.validate!

            instance.put(['v1/trunks', instance.id].join('/'))
          end
        end
      end
    end
  end
end
