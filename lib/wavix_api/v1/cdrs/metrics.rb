# frozen_string_literal: true

require 'wavix_api'

module WavixApi
  module V1
    module Cdrs
      class Metrics
        include WavixApi::V1::Cdrs::CommonVars
        include WavixApi::BaseMethods

        class << self
          def call(params = {})
            instance = new(params)

            instance.validate!
            instance.validate_dates!(::WavixApi::V1::Cdrs::CommonVars::DATE_FIELDS)

            instance.stringify_dates!(
              instance.params,
              fields: ::WavixApi::V1::Cdrs::CommonVars::DATE_FIELDS
            )
            instance.get('v1/cdr/metrics')
          end
        end
      end
    end
  end
end
