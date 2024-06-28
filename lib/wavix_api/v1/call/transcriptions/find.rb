# frozen_string_literal: true

module WavixApi
  module V1
    module Call
      module Transcriptions
        class Find
          include WavixApi::BaseMethods

          @params_schema = {
            type: 'object',
            properties: {
              cdr_id: { type: 'string' }
            }.freeze,
            required: %i[cdr_id].freeze
          }.freeze

          class << self
            def call(params = {})
              instance = new(params)

              instance.validate!

              instance.get("v1/cdr/#{instance.params[:cdr_id]}/transcription")
            end
          end
        end
      end
    end
  end
end
