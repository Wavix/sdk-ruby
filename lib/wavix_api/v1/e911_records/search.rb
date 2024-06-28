# frozen_string_literal: true

require 'wavix_api'

module WavixApi
  module V1
    module E911Records
      class Search
        include WavixApi::BaseMethods

        @params_schema = {
          type: 'object',
          properties: {
            phone_number: {
              type: 'string',
              pattern: ::WavixApi::BaseMethods::ONLY_DIGITS_REGEXP
            }.freeze
          }.freeze
        }.freeze

        class << self
          def call(params = {})
            instance = new(params)

            instance.validate!

            instance.get('v1/e911-records')
          end
        end
      end
    end
  end
end
