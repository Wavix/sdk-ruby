# frozen_string_literal: true

require 'wavix_api'

module WavixApi
  module V2
    module Messages
      module SenderIds
        class Search < ::WavixApi::V2::BaseSearch
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
