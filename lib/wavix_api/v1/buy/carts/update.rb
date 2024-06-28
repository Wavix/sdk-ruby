# frozen_string_literal: true

module WavixApi
  module V1
    module Buy
      module Carts
        class Update
          include WavixApi::BaseMethods

          @params_schema = {
            type: 'object',
            properties: {
              ids: {
                type: 'string',
                pattern: ::WavixApi::BaseMethods::LIST_OF_DIGITS_REGEXP
              }.freeze
            }.freeze,
            required: %i[ids].freeze
          }.freeze

          class << self
            def call(params = {})
              instance = new(params)

              instance.validate!

              instance.patch('v1/buy/cart')
            end
          end
        end
      end
    end
  end
end
