# frozen_string_literal: true

require_relative 'common_vars'

module WavixApi
  module V2
    module Messages
      class All < ::WavixApi::V2::BaseSearch
        include ::WavixApi::V1::Messages::CommonVars

        @params_schema = ::WavixApi::V1::Messages::CommonVars::SEARCH_PARAMS_SCHEMA

        class << self
          private

          def path
            'v2/messages/all'
          end
        end
      end
    end
  end
end
