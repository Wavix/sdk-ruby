# frozen_string_literal: true

require 'wavix_api'

module WavixApi
  module V1
    module Trunks
      class Search
        include WavixApi::BaseMethods

        @params_schema = {
          type: 'object',
          properties: {
            **::WavixApi::BaseMethods::PAGINATION_SCHEMA
          }
        }.freeze

        class << self
          def call(params = {})
            instance = new(params)

            instance.validate!

            instance.get('v1/trunks')
          end
        end
      end
    end
  end
end
