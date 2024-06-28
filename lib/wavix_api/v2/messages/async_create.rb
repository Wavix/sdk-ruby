# frozen_string_literal: true

module WavixApi
  module V2
    module Messages
      class AsyncCreate
        include WavixApi::BaseMethods
        include ::WavixApi::V1::Messages::CommonVars

        @params_schema = ::WavixApi::V1::Messages::CommonVars::CREATE_PARAMS_SCHEMA
        class << self
          def call(params = {})
            instance = new(params)

            instance.validate!

            instance.post('v2/messages/async')
          end
        end
      end
    end
  end
end
