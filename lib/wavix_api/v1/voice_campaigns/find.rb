# frozen_string_literal: true

require 'wavix_api'

module WavixApi
  module V1
    module VoiceCampaigns
      class Find < ::WavixApi::V1::BaseFind
        @params_schema = ::WavixApi::BaseMethods::ONLY_ID_SCHEMA

        class << self
          private

          def path
            'v1/voice-campaigns'
          end
        end
      end
    end
  end
end
