# frozen_string_literal: true

module WavixApi
  module V2
    module Messages
      module SenderIds
        class Destroy < ::WavixApi::V2::BaseDestroy
          @params_schema = ::WavixApi::BaseMethods::ONLY_UUID_SCHEMA

          class << self
            private

            def path
              'v2/messages/sender-ids'
            end
          end
        end
      end
    end
  end
end
