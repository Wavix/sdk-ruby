# frozen_string_literal: true

require 'wavix_api'

module WavixApi
  module V1
    module Billing
      module Invoices
        class Find
          include WavixApi::BaseMethods

          @params_schema = ::WavixApi::BaseMethods::ONLY_ID_SCHEMA

          class << self
            def call(id = nil, save_path: nil)
              instance = new({ id: id })

              instance.validate!

              instance.download(
                ['v1/billing/invoices', instance.id].join('/'),
                headers: {
                  'Content-Disposition' => 'attachment; filename="invoice.pdf"',
                  'Content-Type' => 'application/octet-stream',
                  'Content-Transfer-Encoding' => 'binary'
                },
                save_path: save_path
              )
            end
          end

          def initialize(params = {})
            super(params)
            @save_path = @params[:save_path]
          end

          def call
            self.class.call(id, save_path: @save_path)
          end
        end
      end
    end
  end
end
