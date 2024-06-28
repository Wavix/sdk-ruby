# frozen_string_literal: true

describe WavixApi::V1::Cdrs::Search, type: :service do
  before do
    stub_request(:get, path_with_creds).with(query: formatted_query).to_return(status: 200)
  end

  include_context 'cdrs common search'
end
