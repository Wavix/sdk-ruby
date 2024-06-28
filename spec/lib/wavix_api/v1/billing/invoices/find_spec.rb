# frozen_string_literal: true

describe WavixApi::V1::Billing::Invoices::Find, type: :service do
  subject(:call) { described_class.new(params).call }

  include_context 'with creds'

  let(:id) { 1 }
  let(:path) { "v1/billing/invoices/#{id}" }
  let(:params) { { id: id, save_path: save_path } }
  let(:save_path) { nil }

  context 'when id is null' do
    let(:id) { nil }
    let(:error) { "The property '#/id' of type null did not match the following type: integer" }

    it_behaves_like 'with error'
  end

  context 'when response 200' do
    before do
      stub_request(:get, path_with_creds).with(query: { id: id }).to_return(status: 200)
    end

    it { expect(call).to eq(response_with(status: 200, is_succeed: true)) }

    context 'when with save_path' do
      let(:save_path) { '' }

      before do
        allow(File).to receive(:open)
        call
      end

      it { expect(call).to eq(response_with(status: 200, is_succeed: true)) }
    end
  end

  context 'when response 404' do
    let(:expected_response) do
      response_with(
        status: 404,
        is_succeed: false,
        body: { 'error' => 'Record not found' }
      )
    end

    before do
      stub_request(:get, path_with_creds).with(query: { id: id }).to_return(
        status: 404,
        body: { error: 'Record not found' }.to_json
      )
    end

    it { expect(call).to eq(expected_response) }
  end
end
