# frozen_string_literal: true

module WavixApi
  module V1
    module Papers
      class Find
        include WavixApi::BaseMethods

        @params_schema = {
          type: 'object',
          properties: {
            mydid_id: { type: 'integer' }.freeze,
            doc_type_id: { type: 'integer' }.freeze
          }.freeze,
          required: %i[mydid_id doc_type_id].freeze
        }.freeze

        class << self
          def call(params = {}, save_path: nil)
            instance = new(params)

            instance.validate!

            instance.download(
              "v1/mydids/#{instance.params[:mydid_id]}/papers/#{instance.params[:doc_type_id]}",
              save_path: save_path
            )
          end
        end

        def initialize(params = nil)
          super
          @save_path = params[:save_path]
        end

        def call
          self.class.call(params, save_path: @save_path)
        end
      end
    end
  end
end
