# frozen_string_literal: true

require 'wavix_api'

module WavixApi
  module V1
    module E911Records
      class ValidateAddress
        include WavixApi::BaseMethods

        @params_schema = {
          type: 'object',
          properties: {
            name: { type: 'string' }.freeze,
            phone_number: { type: 'string' }.freeze,
            address: {
              type: 'object',
              properties: {
                street_number: { type: 'string' }.freeze,
                street: { type: 'string' }.freeze,
                location: { type: 'string' }.freeze,
                city: { type: 'string' }.freeze,
                state: { type: 'string' }.freeze,
                zip_code: { type: 'string' }.freeze
              }.freeze,
              required: %i[street_number street location city state zip_code].freeze
            }.freeze
          }.freeze,
          required: %i[name phone_number address].freeze
        }.freeze

        class << self
          def call(params)
            instance = new(params)

            instance.validate!

            instance.post('v1/e911-records/validate-address')
          end
        end
      end
    end
  end
end
