# frozen_string_literal: true

require 'wavix_api'

module WavixApi
  module V1
    module VoiceCampaigns
      class Create
        include WavixApi::BaseMethods

        @params_schema = {
          type: 'object',
          properties: {
            voice_campaign: {
              type: 'object',
              properties: {
                callflow_id: { type: 'integer' }.freeze,
                contact: { type: 'string' }.freeze,
                caller_id: { type: 'string' }.freeze
              }.freeze,
              required: %i[callflow_id contact caller_id].freeze
            }.freeze
          }.freeze,
          required: %i[voice_campaign].freeze
        }.freeze

        class << self
          def call(params = {})
            instance = new(params)

            instance.validate!

            instance.post('v1/voice-campaigns')
          end
        end
      end
    end
  end
end
