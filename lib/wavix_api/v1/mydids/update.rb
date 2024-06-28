# frozen_string_literal: true

require 'wavix_api'

module WavixApi
  module V1
    module Mydids
      class Update
        include WavixApi::BaseMethods

        @params_schema = {
          type: 'object',
          properties: {
            call_recording_enabled: { type: 'boolean' }.freeze,
            transcription_enabled: { type: 'boolean' }.freeze,
            transcription_threshold: { type: 'integer' }.freeze,
            sms_relay_url: { type: 'string' }.freeze,
            id: { type: 'integer' }.freeze
          }.freeze,
          required: %i[
            call_recording_enabled
            transcription_enabled
            transcription_threshold
            id
          ].freeze
        }.freeze

        class << self
          def call(params = {})
            instance = new(params)

            instance.validate!

            instance.patch(['v1/mydids', instance.id].join('/'))
          end
        end
      end
    end
  end
end
