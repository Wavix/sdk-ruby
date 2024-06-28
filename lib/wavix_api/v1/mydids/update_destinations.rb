# frozen_string_literal: true

require 'wavix_api'

module WavixApi
  module V1
    module Mydids
      class UpdateDestinations
        include WavixApi::BaseMethods

        @params_schema = {
          type: 'object',
          properties: {
            ids: {
              anyOf: [
                { type: 'array', items: { type: 'integer' }.freeze }.freeze,
                { type: 'string', pattern: ::WavixApi::BaseMethods::LIST_OF_DIGITS_REGEXP }.freeze
              ].freeze
            },
            dids: {
              anyOf: [
                { type: 'array',
                  items: {
                    type: 'string',
                    pattern: ::WavixApi::BaseMethods::ONLY_DIGITS_REGEXP
                  }.freeze }.freeze,
                { type: 'string', pattern: ::WavixApi::BaseMethods::LIST_OF_DIGITS_REGEXP }.freeze
              ].freeze
            }.freeze,
            sms_relay_url: { type: 'string' }.freeze,
            destinations: {
              type: 'array',
              items: {
                type: 'object',
                properties: {
                  transport: { enum: [1, 4, 5].freeze }.freeze,
                  destination: { type: 'string' }.freeze,
                  priority: { type: 'integer' }.freeze,
                  trunk_id: { type: 'integer' }.freeze
                }.freeze,
                required: %i[transport destination priority].freeze
              }.freeze
            }.freeze
          }.freeze
        }.freeze

        class << self
          def call(params = {})
            instance = new(params)

            instance.validate!

            if instance.params[:ids].nil? && instance.params[:dids].nil?
              instance.raise_error('Either dids or ids is required')
            end

            if !instance.params[:ids].nil? && !instance.params[:dids].nil?
              instance.raise_error('Either dids or ids is supported')
            end

            if instance.params[:destinations].nil? && instance.params[:sms_relay_url].nil?
              instance.raise_error(
                "Either 'destinations' or 'sms_relay_url' or both must be specified"
              )
            end

            instance.post('v1/mydids/update-destinations')
          end
        end
      end
    end
  end
end
