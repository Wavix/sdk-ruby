# frozen_string_literal: true

module WavixApi
  module V1
    module SubOrganizations
      class Create
        include WavixApi::BaseMethods

        @params_schema = {
          type: 'object',
          properties: {
            name: { type: 'string' }.freeze,
            default_destinations: {
              type: 'object',
              properties: {
                sms_endpoint: { type: 'string' }.freeze,
                dlr_endpoint: { type: 'string' }.freeze
              }.freeze
            }.freeze
          }.freeze,
          required: %i[name].freeze
        }.freeze

        class << self
          def call(params = {})
            instance = new(params)

            instance.validate!

            instance.post('v1/sub-organizations')
          end
        end
      end
    end
  end
end
