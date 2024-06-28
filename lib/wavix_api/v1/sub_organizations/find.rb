# frozen_string_literal: true

module WavixApi
  module V1
    module SubOrganizations
      class Find < ::WavixApi::V1::BaseFind
        @params_schema = ::WavixApi::BaseMethods::ONLY_ID_SCHEMA

        class << self
          private

          def path
            'v1/sub-organizations'
          end
        end
      end
    end
  end
end
