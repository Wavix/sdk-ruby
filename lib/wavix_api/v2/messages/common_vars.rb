# frozen_string_literal: true

module WavixApi
  module V1
    module Messages
      module CommonVars
        SEARCH_PARAMS_SCHEMA = {
          type: 'object',
          properties: {
            type: { string: 'string' }.freeze,
            sent_after: { string: 'string' }.freeze,
            sent_before: { string: 'string' }.freeze,
            from: { string: 'string' }.freeze,
            to: { string: 'string' }.freeze,
            message_type: { string: 'string' }.freeze,
            status: { string: 'string' }.freeze,
            tag: { string: 'string' }.freeze,
            **::WavixApi::BaseMethods::PAGINATION_SCHEMA
          }.freeze,
          required: %i[type sent_after sent_before].freeze
        }.freeze
        CREATE_PARAMS_SCHEMA = {
          type: 'object',
          properties: {
            from: { string: 'string' }.freeze,
            to: { string: 'string' }.freeze,
            message_body: {
              type: 'object',
              properties: {
                text: { type: 'string' }.freeze,
                media: {
                  anyOf: [
                    { type: 'array',
                      items: { type: 'string' }.freeze }.freeze,
                    { type: 'string' }.freeze
                  ]
                }.freeze,
                required: %i[text].freeze
              }.freeze
            },
            callback_url: { string: 'string' },
            validity: { integer: 'integer' },
            tag: { string: 'string' }
          }.freeze,
          required: %i[from to message_body].freeze
        }.freeze
      end
    end
  end
end
