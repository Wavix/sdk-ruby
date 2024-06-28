# frozen_string_literal: true

require 'wavix_api'
require_relative 'common_vars'

module WavixApi
  module V1
    module Cdrs
      class AdvancedSearch
        include WavixApi::V1::Cdrs::CommonVars
        include WavixApi::BaseMethods

        TRANSCRIPTION_SPEAKER_SCHEMA = {
          type: 'object',
          properties: {
            must: {
              type: 'array',
              items: { type: 'string' }.freeze
            }.freeze,
            match: {
              type: 'array',
              items: { type: 'string' }.freeze
            }.freeze,
            exclude: {
              type: 'array',
              items: { type: 'string' }.freeze
            }.freeze
          }.freeze
        }.freeze

        @params_schema = {
          type: 'object',
          properties: ::WavixApi::V1::Cdrs::CommonVars::CDR_FIELDS_SCHEMA.merge(
            {
              transcription: {
                type: 'object',
                properties: {
                  language: { type: 'string' },
                  status: { type: 'string' },
                  properties: {
                    agent: TRANSCRIPTION_SPEAKER_SCHEMA,
                    lead: TRANSCRIPTION_SPEAKER_SCHEMA,
                    any: TRANSCRIPTION_SPEAKER_SCHEMA
                  }.freeze
                }.freeze
              }.freeze
            }
          ),
          required: ::WavixApi::V1::Cdrs::CommonVars::CDR_REQUIRED_FIELDS
        }.freeze

        class << self
          def call(params = {})
            instance = new(params)

            instance.validate!
            instance.validate_dates!(::WavixApi::V1::Cdrs::CommonVars::DATE_FIELDS)

            instance.stringify_dates!(instance.params,
                                      fields: ::WavixApi::V1::Cdrs::CommonVars::DATE_FIELDS)
            instance.post('v1/cdr')
          end
        end
      end
    end
  end
end
