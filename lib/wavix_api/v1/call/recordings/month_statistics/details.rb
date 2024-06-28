# frozen_string_literal: true

require 'wavix_api'

module WavixApi
  module V1
    module Call
      module Recordings
        module MonthStatistics
          class Details
            include WavixApi::BaseMethods

            @params_schema = ::WavixApi::BaseMethods::ONLY_ID_SCHEMA

            class << self
              def call(id = nil)
                instance = new({ id: id })

                instance.validate!

                instance.get(
                  ['v1/recording/month-statistics', instance.id, 'details'].join('/')
                )
              end
            end

            def call
              self.class.call(id)
            end
          end
        end
      end
    end
  end
end
