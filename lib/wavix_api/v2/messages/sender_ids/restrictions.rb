# frozen_string_literal: true

module WavixApi
  module V2
    module Messages
      module SenderIds
        class Restrictions
          include WavixApi::BaseMethods

          @params_schema = {
            type: 'object',
            properties: {
              country: { type: 'string' }.freeze,
              type: { enum: %w[numeric alphanumeric] }.freeze
            }.freeze,
            required: %i[country type].freeze
          }.freeze

          class << self
            def call(params = {})
              instance = new(params)

              instance.validate!

              instance.get('v2/messages/sender-ids/restrictions')
            end
          end
        end
      end
    end
  end
end
