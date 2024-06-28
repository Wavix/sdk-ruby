# frozen_string_literal: true

module WavixApi
  module V3
    module Messages
      module SenderIds
        class Create
          include WavixApi::BaseMethods

          MONTHLY_VOLUMES = ['1-1000', '1001-20000', '20001-50000',
                             '50001-100000', 'More than 100000'].freeze
          USECASES = %w[transactional promo authentication].freeze

          @params_schema = {
            type: 'object',
            properties: {
              type: { enum: %w[numeric alphanumeric] }.freeze,
              sender_id: { type: 'string' }.freeze,
              countries: {
                type: 'array',
                items: { type: 'string' }.freeze
              },
              usecase: { enum: USECASES }.freeze,
              monthly_volume: { enum: MONTHLY_VOLUMES }.freeze,
              samples: {
                type: 'array',
                items: { type: 'string' }.freeze
              }
            }.freeze,
            required: %i[
              type
              sender_id
              countries
              usecase
              samples
            ].freeze
          }.freeze
          class << self
            def call(params = {})
              instance = new(params)

              instance.validate!

              instance.post('v3/messages/sender-ids')
            end
          end
        end
      end
    end
  end
end
