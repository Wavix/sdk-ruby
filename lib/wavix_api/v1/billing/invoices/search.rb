# frozen_string_literal: true

require 'wavix_api'

module WavixApi
  module V1
    module Billing
      module Invoices
        class Search < ::WavixApi::V1::BaseSearch
          class << self
            private

            def path
              'v1/billing/invoices'
            end
          end
        end
      end
    end
  end
end
