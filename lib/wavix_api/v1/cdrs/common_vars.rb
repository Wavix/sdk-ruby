# frozen_string_literal: true

module WavixApi
  module V1
    module Cdrs
      module CommonVars
        DATE_FIELDS = %i[from to].freeze
        CDR_REQUIRED_FIELDS = DATE_FIELDS + %i[type]
        CDR_FIELDS_SCHEMA = {
          type: { enum: %w[placed received] }.freeze,
          from_search: { type: 'string' }.freeze,
          to_search: { type: 'string' }.freeze,
          page: { type: 'integer' }.freeze,
          per_page: { type: 'integer' }.freeze,
          disposition: { type: 'string' }.freeze,
          uuid: { type: 'string' }.freeze,
          sip_trunk: { type: 'string' }.freeze
        }.freeze
      end
    end
  end
end
