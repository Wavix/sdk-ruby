# frozen_string_literal: true

module WavixApi
  module V2
    module Messages
      module SenderIds
        class Create
          include WavixApi::BaseMethods

          @params_schema = {
            type: 'object',
            properties: {
              type: { enum: %w[numeric alphanumeric] }.freeze,
              sender_id: { type: 'string' }.freeze,
              countries: {
                type: 'array',
                items: { type: 'string' }.freeze
              }
            }.freeze,
            required: %i[
              type
              sender_id
              countries
            ].freeze
          }.freeze

          class << self
            def call(params = {})
              instance = new(params)

              instance.validate!

              instance.post('v2/messages/sender-ids')
            end
          end
        end
      end
    end
  end
end
