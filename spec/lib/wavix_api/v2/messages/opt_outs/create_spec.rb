# frozen_string_literal: true

describe WavixApi::V2::Messages::OptOuts::Create, type: :service do
  subject(:call) { described_class.new(params).call }

  include_context 'with creds'

  let(:path) { 'v2/messages/opt-outs' }
  let(:valid_params) do
    {
      number: '123421232'
    }
  end
  let(:params) { valid_params }

  shared_context 'when succeed' do
    before do
      stub_request(:post, path_with_creds).with(body: params.to_json).to_return(status: 200)
      call
    end

    it { expect(call).to eq(response_with(status: 200, is_succeed: true)) }
  end

  context 'without params' do
    let(:params) { {} }
    let(:error) do
      "The property '#/' did not contain a required property of 'number'"
    end

    it_behaves_like 'with error'
  end

  context 'with params' do
    shared_context 'when missing field in params' do |field|
      let(:params) { valid_params.except(field) }

      it_behaves_like 'when required field missing', field
    end

    it_behaves_like 'when succeed'
    it_behaves_like 'when missing field in params', :number
  end
end
