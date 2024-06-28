# frozen_string_literal: true

require 'json'
require 'faraday'
require 'faraday/multipart'
require_relative 'middleware/follow_redirects_middleware'

module WavixApi
  class << self
    DEFAULT_HOST = 'api.wavix.com'

    attr_accessor :api_key, :host

    def client
      Client.new(host: @host, api_key: @api_key)
    end
  end

  module HTTPMethods
    DEFAULT_HEADERS = { 'Content-Type' => 'application/json' }.freeze
    Response = Struct.new(:status, :status_str, :body, :parsed_body, 'success?', :filename)
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
      'dib' => 'image/dib',
      'amr' => 'audio/amr',
      '3g' => 'audio/3gpp',
      'wav' => 'audio/wav',
      'wave' => 'audio/wav',
      'mp3' => 'audio/mpeg',
      'aac' => 'audio/aac',
      'gcp' => 'audio/gcp',
      'midi' => 'audio/midi',
      'midp' => 'audio/midi'
    }.freeze
    FILE_NAMES = %i[attachment paper invoice].freeze

    def request(method, path, params: {}, body: nil, headers: {})
      connection = Faraday.new(
        url: "https://#{@host}",
        params: { appid: @api_key },
        headers: DEFAULT_HEADERS.merge(headers)
      ) do |builder|
        yield(builder) if block_given?

        builder.use FollowRedirectsMiddleware
        builder.adapter Faraday.default_adapter
      end

      response =
        if %w[GET DELETE].index(method)
          connection.send(method.downcase, path, params)
        else
          connection.send(method.downcase, path) do |request|
            (params || {}).each { |k, v| request.params[k] = v }
            request.body = body if body
          end
        end

      parsed_body = begin
        JSON.parse(response.body)
      rescue JSON::ParserError
        {}
      end

      Response.new(
        response.status,
        response.reason_phrase,
        response.body,
        parsed_body,
        response.success?,
        filename(response.env.response_headers, path)
      )
    end

    def filename(response_headers, path)
      file_by_disposition = response_headers['content-disposition']&.match(/filename="(.+)"/)

      return file_by_disposition[1] if file_by_disposition

      content_type = CONTENT_TYPES.key(response_headers[:content_type])

      return unless content_type

      "#{FILE_NAMES.find { |el| path.include?(el) }}_#{Time.now.to_i}.#{content_type}"
    end
  end

  class Client
    include HTTPMethods

    def initialize(host:, api_key:)
      @host = host.empty? ? DEFAULT_HOST : host
      @api_key = api_key
    end

    def get(path, params: {}, headers: {})
      request('GET', path, params: params, headers: HTTPMethods::DEFAULT_HEADERS.merge(headers))
    end

    def patch(path, body: {}, params: {})
      request('PATCH', path, params: params, body: body.to_json)
    end

    def delete(path, params: {})
      request('DELETE', path, params: params)
    end

    def put(path, body: {}, params: {})
      request('PUT', path, params: params, body: body.to_json)
    end

    def post(path, body: {}, params: {}, with_file: false,
             headers: { 'Content-Type' => 'application/json' })
      body = body.to_json unless with_file
      headers['Content-Type'] = 'multipart/form-data' if with_file

      request('POST', path, params: params, body: body, headers: headers) do |builder|
        builder.request :multipart if with_file
      end
    end

    def download(path, headers: {}, params: {}, save_path: nil)
      if save_path
        dirname = File.dirname(save_path)
        dir_parts = dirname.split(%r{[/\\]}).reject(&:empty?)

        (1..dir_parts.size).each do |n|
          dir = dir_parts[0...n].join('/')
          Dir.mkdir("/#{dir}") unless Dir.exist?("/#{dir}")
        end
      end

      response = request('GET', path, params: params, headers: headers)

      return response if save_path.nil? || !response.success? || response.filename.nil?

      filename = if CONTENT_TYPES.keys.find { |el| save_path.include?(".#{el}") }
                   save_path
                 else
                   "#{save_path}/#{response.filename}"
                 end

      File.open(filename, 'wb') { |f| f.write response.body }
      response
    end
  end
end
