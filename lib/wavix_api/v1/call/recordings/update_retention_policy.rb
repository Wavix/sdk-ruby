# frozen_string_literal: true

module WavixApi
  module V1
    module Call
      module Recordings
        class UpdateRetentionPolicy
          include WavixApi::BaseMethods

          @params_schema = {
            type: 'object',
            properties: {
              settings: {
                type: 'object',
                properties: {
                  recording_store_months: { type: 'integer' }.freeze
                }.freeze,
                required: %i[recording_store_months].freeze
              }.freeze
            }.freeze,
            required: %i[settings].freeze
          }.freeze

          class << self
            def call(params = {})
              instance = new(params)

              instance.validate!

              instance.patch('v1/recordings/retention-policy')
            end
          end
        end
      end
    end
  end
end
