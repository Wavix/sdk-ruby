# frozen_string_literal: true

describe WavixApi::V2::Messages::SenderIds::Restrictions, type: :service do
  subject(:call) { described_class.new(params).call }

  include_context 'with creds'

  let(:path) { 'v2/messages/sender-ids/restrictions' }
  let(:params) { { country: country, type: type } }
  let(:country) { 'AW' }
  let(:type) { 'alphanumeric' }

  context 'without params' do
    let(:params) { {} }
    let(:error) do
      "The property '#/' did not contain a required property of 'country'"
    end

    it_behaves_like 'with error'
  end

  context 'when country is invalid' do
    let(:country) { 123 }
    let(:error) do
      "The property '#/country' of type integer did not match the following type: string"
    end

    it_behaves_like 'with error'
  end

  context 'when type is not available' do
    let(:params) { { type: 'invalid' } }
    let(:error) do
      "The property '#/type' value \"invalid\" did not match one of the following values: " \
      'numeric, alphanumeric'
    end

    it_behaves_like 'with error'
  end

  context 'when all valid' do
    before do
      stub_request(:get, path_with_creds).with(query: params).to_return(status: 200)
    end

    it { expect(call).to eq(response_with(status: 200, is_succeed: true)) }
  end
end
