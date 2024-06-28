# frozen_string_literal: true

module WavixApi
  module V1
    module Trunks
      class Destroy < ::WavixApi::V1::BaseDestroy
        @params_schema = ::WavixApi::BaseMethods::ONLY_ID_SCHEMA

        class << self
          private

          def path
            'v1/trunks'
          end
        end
      end
    end
  end
end
