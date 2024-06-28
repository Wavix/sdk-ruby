# frozen_string_literal: true

require 'wavix_api'

module WavixApi
  module V1
    module Mydids
      class Search
        include WavixApi::BaseMethods

        @params_schema = {
          type: 'object',
          properties: {
            name: { type: 'string' }.freeze,
            search: { type: 'string' }.freeze,
            city_id: { type: 'integer' }.freeze,
            label_present: { type: 'boolean' }.freeze,
            label: { type: 'string' }.freeze,
            **::WavixApi::BaseMethods::PAGINATION_SCHEMA
          }.freeze
        }.freeze

        class << self
          def call(params = {})
            instance = new(params)

            instance.validate!

            instance.get('v1/mydids')
          end
        end
      end
    end
  end
end
