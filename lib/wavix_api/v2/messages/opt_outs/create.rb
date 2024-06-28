# frozen_string_literal: true

module WavixApi
  module V2
    module Messages
      module OptOuts
        class Create
          include WavixApi::BaseMethods

          @params_schema = {
            type: 'object',
            properties: {
              number: { type: 'string' }.freeze,
              sender_id: { type: 'string' }.freeze
            }.freeze,
            required: %i[
              number
            ].freeze
          }.freeze

          class << self
            def call(params = {})
              instance = new(params)

              instance.validate!

              instance.post('v2/messages/opt-outs')
            end
          end
        end
      end
    end
  end
end
