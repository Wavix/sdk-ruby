# frozen_string_literal: true

require 'wavix_api'

module WavixApi
  module V3
    module Messages
      module SenderIds
        class Search < ::WavixApi::V2::BaseSearch
          class << self
            private

            def path
              'v3/messages/sender-ids'
            end
          end
        end
      end
    end
  end
end
