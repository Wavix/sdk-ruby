# frozen_string_literal: true

require 'wavix_api'

module WavixApi
  module V1
    module Mydids
      class Destroy
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
                {
                  type: 'array',
                  items: {
                    type: 'string',
                    pattern: ::WavixApi::BaseMethods::ONLY_DIGITS_REGEXP
                  }.freeze
                }.freeze,
                { type: 'string', pattern: ::WavixApi::BaseMethods::LIST_OF_DIGITS_REGEXP }.freeze
              ].freeze
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

            instance.delete('v1/mydids')
          end
        end
      end
    end
  end
end
