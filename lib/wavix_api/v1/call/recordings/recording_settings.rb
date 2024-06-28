# frozen_string_literal: true

module WavixApi
  module V1
    module Call
      module Recordings
        class RecordingSettings
          include WavixApi::BaseMethods

          @params_schema = {
            type: 'object',
            properties: {
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

              instance.get('v1/recordings/recording-settings')
            end
          end
        end
      end
    end
  end
end
