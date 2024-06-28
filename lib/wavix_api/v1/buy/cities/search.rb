# frozen_string_literal: true

module WavixApi
  module V1
    module Buy
      module Cities
        class Search
          include WavixApi::BaseMethods

          @params_schema = {
            type: 'object',
            properties: {
              country_id: { type: 'integer' }.freeze,
              region_id: { type: 'integer' }.freeze,
              type_filter: { type: 'string' }.freeze,
              text_enabled_only: { type: 'boolean' }.freeze
            }.freeze,
            required: %i[country_id].freeze
          }.freeze

          class << self
            def call(params = {})
              instance = new(params)

              instance.validate!

              instance.get(path(instance.params))
            end

            private

            def path(params)
              country_id = params[:country_id]
              region_id = params[:region_id]

              if region_id.nil?
                "v1/buy/countries/#{country_id}/cities"
              else
                "v1/buy/countries/#{country_id}/regions/#{region_id}/cities"
              end
            end
          end
        end
      end
    end
  end
end
