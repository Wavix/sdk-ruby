# frozen_string_literal: true

describe WavixApi::V1::Cdrs::AdvancedSearch, type: :service do
  before do
    stub_request(:post, path_with_creds).with(body: formatted_query.to_json).to_return(status: 200)
  end

  include_context 'cdrs common search'
end
