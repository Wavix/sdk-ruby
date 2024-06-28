# frozen_string_literal: true

describe WavixApi::V2::Messages::Create, type: :service do
  subject(:call) { described_class.new(params).call }

  include_context 'with creds'

  let(:path) { 'v2/messages' }
  let(:valid_params) do
    {
      from: '32231112322',
      to: '12334212321',
      message_body: {
        text: 'test.',
        media: []
      }
    }
  end
  let(:params) { valid_params }

  before do
    stub_request(:post, path_with_creds).with(body: params.to_json).to_return(status: 200)
  end

  shared_context 'when succeed' do
    before do
      call
    end

    it { expect(call).to eq(response_with(status: 200, is_succeed: true)) }
  end

  context 'without params' do
    let(:valid_params) { {} }
    let(:error) do
      "The property '#/' did not contain a required property of 'from'"
    end

    it_behaves_like 'with error'
  end

  context 'with params' do
    shared_context 'when missing field in params' do |field|
      let(:params) { valid_params.except(field) }

      it_behaves_like 'when required field missing', field
    end

    it_behaves_like 'when succeed'
    it_behaves_like 'when missing field in params', :from
    it_behaves_like 'when missing field in params', :to
    it_behaves_like 'when missing field in params', :message_body
  end
end
