# frozen_string_literal: true

describe WavixApi::V2::Messages::All, type: :service do
  subject(:call) do
    described_class.call(params)
  end

  include_context 'with creds'

  let(:params) do
    { type: 'outbound', sent_after: '2023-01-21', sent_before: '2023-01-31' }
  end
  let(:path) { 'v2/messages/all' }

  context 'with required params' do
    before do
      stub_request(:get,
                   "#{path_with_creds}&sent_after=2023-01-21&sent_before=2023-01-31&type=outbound")
        .to_return(status: 200)
    end

    it { expect(call).to eq(response_with(status: 200, is_succeed: true)) }
  end

  context 'when error in params' do
    let(:params) { {} }
    let(:error) do
      "The property '#/' did not contain a required property of 'type'"
    end

    before do
      stub_request(:get, path_with_creds)
        .to_return(status: 200)
    end

    it_behaves_like 'with error'
  end
end
