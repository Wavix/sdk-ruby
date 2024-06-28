# frozen_string_literal: true

module WavixApi
  module V1
    module Buy
      module Countries
        class Search
          include WavixApi::BaseMethods

          @params_schema = {
            type: 'object',
            properties: {
              type_filter: { type: 'string' }.freeze,
              text_enabled_only: { type: 'boolean' }.freeze
            }.freeze
          }.freeze

          class << self
            def call(params = {})
              instance = new(params)

              instance.validate!

              instance.get('v1/buy/countries')
            end
          end
        end
      end
    end
  end
end
