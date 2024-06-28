# frozen_string_literal: true

module WavixApi
  module V1
    module Buy
      module Regions
        class Search
          include WavixApi::BaseMethods

          @params_schema = {
            type: 'object',
            properties: {
              country_id: { type: 'integer' }.freeze,
              type_filter: { type: 'string' }.freeze,
              text_enabled_only: { type: 'boolean' }.freeze
            }.freeze,
            required: %i[country_id].freeze
          }.freeze

          class << self
            def call(params = {})
              instance = new(params)

              instance.validate!

              instance.get("v1/buy/countries/#{instance.params[:country_id]}/regions")
            end
          end
        end
      end
    end
  end
end
