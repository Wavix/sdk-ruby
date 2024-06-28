# frozen_string_literal: true

require 'wavix_api'

module WavixApi
  module V1
    module E911Records
      class Destroy
        include WavixApi::BaseMethods

        @params_schema = {
          type: 'object',
          properties: {
            phone_number: { type: 'string' }.freeze
          }.freeze,
          required: %i[phone_number].freeze
        }.freeze

        class << self
          def call(params = {})
            instance = new(params)

            instance.validate!

            instance.delete('v1/e911-records')
          end
        end
      end
    end
  end
end
