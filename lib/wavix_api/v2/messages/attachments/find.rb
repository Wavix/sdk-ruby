# frozen_string_literal: true

require 'wavix_api'

module WavixApi
  module V2
    module Messages
      module Attachments
        class Find
          include WavixApi::BaseMethods

          @params_schema = {
            type: 'object',
            properties: {
              id: { type: 'string' }.freeze,
              sms_id: { type: 'string' }.freeze,
              format: { type: 'string' }.freeze
            }.freeze,
            required: %i[id sms_id format].freeze
          }.freeze

          def initialize(params = {})
            super(params)
            @id = nil
          end

          class << self
            def call(params = {}, save_path: nil)
              instance = new(params)
              instance.validate!
              id = instance.params[:id]
              format = instance.params[:format]

              instance.download(
                path(instance.params[:sms_id], id, format),
                headers:
                  {
                    'Content-Disposition' => "attachment; filename='#{id}.#{format}}'",
                    'Content-Type' => 'application/octet-stream',
                    'Content-Transfer-Encoding' => 'binary'
                  },
                save_path: save_path
              )
            end

            def path(sms_id, id, format)
              ['v2/messages/attachments', sms_id, "#{id}.#{format}"]
                .join('/')
            end
          end

          def call(save_path: nil)
            self.class.call(params, save_path: save_path)
          end
        end
      end
    end
  end
end
