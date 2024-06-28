# frozen_string_literal: true

require 'wavix_api'

module WavixApi
  module V1
    module Mydids
      class Cities
        include WavixApi::BaseMethods

        @params_schema = {
          type: 'object',
          properties: {
            name: { type: 'string' }.freeze,
            **::WavixApi::BaseMethods::PAGINATION_SCHEMA
          }.freeze,
          required: %i[name].freeze
        }.freeze

        class << self
          def call(params = {})
            instance = new(params)

            instance.validate!

            instance.get('v1/mydids/cities')
          end
        end
      end
    end
  end
end
