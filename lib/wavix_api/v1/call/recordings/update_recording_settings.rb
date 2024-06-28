# frozen_string_literal: true

module WavixApi
  module V1
    module Call
      module Recordings
        class UpdateRecordingSettings
          include WavixApi::BaseMethods

          @params_schema = {
            type: 'object',
            properties: {
              recording: {
                type: 'object',
                properties: {
                  new_state: { type: 'boolean' },
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
                }.freeze,
                required: %i[new_state].freeze
              }.freeze
            }.freeze,
            required: %i[recording].freeze
          }.freeze

          class << self
            def call(params = {})
              instance = new(params)

              instance.validate!

              instance.put('v1/recordings/recording-settings')
            end
          end
        end
      end
    end
  end
end
