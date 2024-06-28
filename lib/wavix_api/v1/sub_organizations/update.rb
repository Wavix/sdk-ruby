# frozen_string_literal: true

require 'wavix_api'

module WavixApi
  module V1
    module SubOrganizations
      class Update
        include WavixApi::BaseMethods

        @params_schema = {
          type: 'object',
          properties: {
            name: { type: 'string' }.freeze,
            status: { enum: %w[active disabled].freeze }.freeze,
            default_destinations: {
              type: 'object',
              properties: {
                sms_endpoint: { type: 'string' }.freeze,
                dlr_endpoint: { type: 'string' }.freeze
              }.freeze
            }.freeze,
            id: { type: 'integer' }.freeze
          }.freeze,
          required: %i[name id].freeze
        }.freeze

        class << self
          def call(params = {})
            instance = new(params)

            instance.validate!

            instance.patch(['v1/sub-organizations', instance.id].join('/'))
          end
        end
      end
    end
  end
end
