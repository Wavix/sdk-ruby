# frozen_string_literal: true

describe WavixApi::V1::Buy::Carts::Update, type: :service do
  subject(:call) { described_class.new(params).call }

  include_context 'with creds'

  let(:path) { 'v1/buy/cart' }
  let(:params) { { ids: ids } }
  let(:ids) { '123456789,9876543' }

  shared_context 'when succeed' do
    before do
      stub_request(:patch, path_with_creds).with(body: params.to_json).to_return(status: 200)
    end

    it { expect(call).to eq(response_with(status: 200, is_succeed: true)) }
  end

  context 'without params' do
    let(:params) { {} }
    let(:error) do
      "The property '#/' did not contain a required property of 'ids'"
    end

    it_behaves_like 'with error'
  end

  context 'with params' do
    context 'when invalid argument value' do
      let(:ids) { '123213,' }

      it_behaves_like 'when invalid lits of digits format', '#/ids', '123213,'
    end

    context 'when invalid format of value' do
      let(:ids) { 1_234_567 }

      it_behaves_like 'when did not match type string', '#/ids', 'integer'
    end

    context 'when valid argument value' do
      it_behaves_like 'when succeed'
    end
  end
end
