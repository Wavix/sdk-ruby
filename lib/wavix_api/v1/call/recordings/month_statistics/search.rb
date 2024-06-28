# frozen_string_literal: true

require 'wavix_api'

module WavixApi
  module V1
    module Call
      module Recordings
        module MonthStatistics
          class Search
            include WavixApi::BaseMethods

            @params_schema = {
              type: 'object',
              properties: {
                year: { type: 'integer' }.freeze,
                month: { type: 'integer' }.freeze
              }.freeze
            }.freeze

            class << self
              def call(params = {})
                instance = new(params)

                instance.validate!

                instance.get('v1/recording/month-statistics')
              end
            end
          end
        end
      end
    end
  end
end
