# frozen_string_literal: true

require 'wavix_api'

module WavixApi
  module V1
    module SubOrganizations
      class Search
        include WavixApi::BaseMethods

        @params_schema = {
          type: 'object',
          properties: {
            status: { enum: %w[enabled disabled].freeze }.freeze,
            **::WavixApi::BaseMethods::PAGINATION_SCHEMA
          }.freeze
        }.freeze

        class << self
          def call(params = {})
            instance = new(params)

            instance.validate!

            instance.get('v1/sub-organizations')
          end
        end
      end
    end
  end
end
