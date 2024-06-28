# frozen_string_literal: true

module WavixApi
  module V1
    module Papers
      class Create
        include WavixApi::BaseMethods

        CONTENT_TYPES = {
          'jpeg' => 'image/jpeg',
          'jpg' => 'image/jpeg',
          'gif' => 'image/gif',
          'png' => 'image/png',
          'pdf' => 'application/pdf',
          'bmp' => 'image/bmp',
          'tiff' => 'image/tiff',
          'doc' => 'application/msword',
          'docx' => 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
          'dib' => 'image/dib'
        }.freeze

        @params_schema = {
          type: 'object',
          properties: {
            did_ids: {
              type: 'string',
              pattern: ::WavixApi::BaseMethods::LIST_OF_DIGITS_REGEXP
            }.freeze,
            doc_id: { type: 'integer' }.freeze
          }.freeze,
          required: %i[did_ids doc_id doc_attachment].freeze
        }.freeze

        class << self
          def call(params = {})
            instance = new(params)
            instance.validate!

            doc_attachment = instance.params[:doc_attachment]
            unless doc_attachment.respond_to?(:path)
              instance.raise_error('doc_attachment must respond to method "path"')
            end

            extention = instance.file_extention(doc_attachment)
            unless CONTENT_TYPES.keys.include?(extention)
              instance.raise_error(
                "doc_attachment have invalid extention. Valid are #{CONTENT_TYPES.keys}"
              )
            end

            instance.params[:doc_attachment] = instance.format_file(
              doc_attachment,
              content_type: CONTENT_TYPES[extention]
            )
            instance.post(
              'v1/mydids/papers',
              with_file: true,
              headers: { 'Content-Disposition' => 'form-data', 'Content-Type' => '' }
            )
          end
        end
      end
    end
  end
end
