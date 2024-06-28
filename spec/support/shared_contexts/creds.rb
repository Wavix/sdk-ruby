# frozen_string_literal: true

shared_context 'with creds' do
  let(:host) { 'api.wavix.com' }
  let(:api_key) { 'token' }
  let(:id) { nil }
  let(:full_path) { "https://#{host}/#{path}" }
  let(:path_with_creds) do
    "#{full_path}?appid=#{api_key}".tap do |res|
      res << "&id=#{id}" unless id.nil?
    end
  end

  before do
    WavixApi.host = host
    WavixApi.api_key = api_key
  end
end
