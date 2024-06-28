# frozen_string_literal: true

require 'wavix_api'

module WavixApi
  module V1
    module Mydids
      class UpdateSmsEnabled
        include WavixApi::BaseMethods

        @params_schema = {
          type: 'object',
          properties: {
            sms_enabled: { type: 'boolean' }.freeze,
            id: { type: 'integer' }.freeze
          }.freeze,
          required: %i[sms_enabled id].freeze
        }.freeze

        class << self
          def call(params = {})
            instance = new(params)

            instance.validate!

            instance.put('v1/mydids/update-sms-enabled')
          end
        end
      end
    end
  end
end
