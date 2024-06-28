# frozen_string_literal: true

require 'json-schema'

module Services
  class FieldsValidator
    attr_accessor :fields, :schema
    attr_reader :error

    def initialize(attributes = {})
      attributes.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end

    def call
      JSON::Validator.validate!(schema, fields)
    rescue JSON::Schema::ValidationError => e
      @error = e.message
    end

    def valid?
      @error.nil?
    end
  end
end
