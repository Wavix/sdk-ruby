# frozen_string_literal: true

module WavixApi
  module V2
    module Messages
      class Find < ::WavixApi::V2::BaseFind
        @params_schema = ::WavixApi::BaseMethods::ONLY_UUID_SCHEMA

        class << self
          private

          def path
            'v2/messages'
          end
        end
      end
    end
  end
end
