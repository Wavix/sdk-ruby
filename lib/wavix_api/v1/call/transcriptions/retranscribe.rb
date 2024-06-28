# frozen_string_literal: true

module WavixApi
  module V1
    module Call
      module Transcriptions
        class Retranscribe
          include WavixApi::BaseMethods

          @params_schema = {
            type: 'object',
            properties: {
              cdr_id: { type: 'string' }.freeze,
              language: {
                enum: WavixApi::BaseMethods::AVAILABLE_TRANSCRIPTION_LANGUAGES
              }.freeze,
              webhook_url: { type: 'string' }.freeze
            }.freeze,
            required: %i[cdr_id language webhook_url].freeze
          }.freeze

          class << self
            def call(params = {})
              instance = new(params)

              instance.validate!

              instance.put("v1/cdr/#{instance.params[:cdr_id]}/retranscribe")
            end
          end
        end
      end
    end
  end
end
