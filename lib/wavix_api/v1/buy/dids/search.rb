# frozen_string_literal: true

module WavixApi
  module V1
    module Buy
      module Dids
        class Search
          include WavixApi::BaseMethods

          @params_schema = {
            type: 'object',
            properties: {
              country_id: { type: 'integer' }.freeze,
              city_id: { type: 'integer' }.freeze,
              type_filter: { type: 'string' }.freeze,
              text_enabled_only: { type: 'boolean' }.freeze,
              **::WavixApi::BaseMethods::PAGINATION_SCHEMA
            }.freeze,
            required: %i[country_id city_id].freeze
          }.freeze

          class << self
            def call(params = {})
              instance = new(params)

              instance.validate!

              instance.get(path(instance.params))
            end

            private

            def path(params)
              "v1/buy/countries/#{params[:country_id]}/cities/#{params[:city_id]}/dids"
            end
          end
        end
      end
    end
  end
end
