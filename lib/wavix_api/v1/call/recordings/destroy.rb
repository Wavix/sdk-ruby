# frozen_string_literal: true

require 'wavix_api'

module WavixApi
  module V1
    module Call
      module Recordings
        class Destroy < ::WavixApi::V1::BaseDestroy
          @params_schema = ::WavixApi::BaseMethods::ONLY_ID_SCHEMA

          class << self
            private

            def path
              'v1/recordings'
            end
          end
        end
      end
    end
  end
end
