# frozen_string_literal: true

require 'services/fields_validator'

module WavixApi
  class ValidationError < StandardError; end

  module BaseMethods
    attr_reader :params, :id, :client

    DEFAULT_HEADERS = { 'Content-Type' => 'application/json' }.freeze
    PAGINATION_SCHEMA = {
      page: { type: 'integer' },
      per_page: { type: 'integer' }
    }.freeze
    ONLY_ID_SCHEMA = {
      type: 'object',
      properties: {
        id: { type: 'integer' }.freeze
      }.freeze,
      required: %i[id].freeze
    }.freeze
    ONLY_UUID_SCHEMA = {
      type: 'object',
      properties: {
        id: { type: 'string' }.freeze
      }.freeze,
      required: %i[id].freeze
    }.freeze
    AVAILABLE_TRANSCRIPTION_LANGUAGES = %w[en de es fr it].freeze
    BASE_DATE_FORMAT = '%Y-%m-%d'
    ONLY_DIGITS_REGEXP = /^\d+$/.freeze
    IP_REGEXP = /^\d(\.\d)*$/.freeze
    LIST_OF_DIGITS_REGEXP = /^\d+(,\d+)*$/.freeze

    class << self
      attr_accessor :params_schema
    end

    def initialize(params = {})
      @params = deep_symbolize_keys(params)
      @id = @params[:id]
      @client = ::WavixApi.client
    end

    def validate!
      validate_params! unless self.class.instance_variable_get('@params_schema').nil?
      validate_appid!
    end

    def validate_dates!(fields, step_params: params)
      invalid_fields = fields.select do |field|
        value = step_params[field.to_sym]
        nested = field.to_s.split('.')
        # INFO: in case of nested key. For example: item.date_from, item.nested_item.date_from
        if nested.count > 1
          validate_dates!(nested[1..-1], step_params: step_params[nested.first.to_i])
        else
          !value.is_a?(::DateTime) && (!value.nil? && !value.empty?)
        end
      end
      return true if invalid_fields.empty?

      raise_error("Fields #{invalid_fields} must be a DateTime")
    end

    def stringify_dates!(params, fields:, format: BASE_DATE_FORMAT)
      fields.each do |field|
        nested = field.to_s.split('.')
        # INFO: in case of nested key. For example: item.date_from, item.nested_item.date_from
        if nested.count > 1
          key = nested.first.to_sym
          stringify_dates!(params[key], fields: nested[1..-1].join('.'), format: format)
        else
          value = params[field.to_sym]
          next if !value.is_a?(::DateTime) && (value.nil? || value.empty?)

          params[field.to_sym] = value.strftime(format)
        end
      end
    end

    def get(path, headers: {})
      client.get(
        path,
        params: params.merge(additional_params),
        headers: DEFAULT_HEADERS.merge(headers)
      )
    end

    def download(path, headers: {}, save_path: nil)
      client.download(
        path,
        params: params.merge(additional_params),
        headers: DEFAULT_HEADERS.merge(headers),
        save_path: save_path
      )
    end

    def post(path, with_file: false, headers: {})
      client.post(
        path,
        params: additional_params,
        headers: DEFAULT_HEADERS.merge(headers),
        body: params.except(:id),
        with_file: with_file
      )
    end

    def put(path)
      client.put(path, body: params.except(:id), params: additional_params)
    end

    def patch(path)
      client.patch(path, body: params.except(:id), params: additional_params)
    end

    def delete(path)
      client.delete(path, params: params.merge(additional_params))
    end

    def raise_error(error)
      raise ValidationError, error
    end

    def format_file(file, content_type: 'multipart/form-data')
      Faraday::Multipart::FilePart.new(file.path, content_type)
    end

    def file_extention(file)
      File.extname(file.path).to_s[1..-1]
    end

    def call
      self.class.call(params)
    end

    private

    def deep_transform_keys_in_object(object, &block)
      case object
      when Hash
        object.each_with_object({}) do |(key, value), result|
          result[yield(key)] = deep_transform_keys_in_object(value, &block)
        end
      when Array
        object.map { |e| deep_transform_keys_in_object(e, &block) }
      else
        object
      end
    end

    def deep_symbolize_keys(object)
      deep_transform_keys_in_object(object) do |key|
        key.to_sym
      rescue StandardError
        key
      end
    end

    def validate_appid!
      raise_error('api_key is required') if WavixApi.api_key.nil? || WavixApi.api_key.empty?
    end

    def validate_params!
      service = ::Services::FieldsValidator.new(
        fields: params,
        schema: self.class.instance_variable_get('@params_schema')
      )
      service.call
      raise_error(service.error) unless service.valid?
    end

    def additional_params
      { appid: WavixApi.api_key }.tap do |res|
        res[:id] = id if !id.nil? && (id.is_a?(Integer) || id.empty?)
      end
    end
  end
end
