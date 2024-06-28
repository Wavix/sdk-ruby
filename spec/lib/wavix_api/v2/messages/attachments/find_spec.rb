# frozen_string_literal: true

describe WavixApi::V2::Messages::Attachments::Find, type: :service do
  subject(:call) do
    described_class.new(params).call
  end

  include_context 'with creds'

  let(:params) do
    { id: '123', format: 'jpg', sms_id: '123123' }
  end
  let(:path) { 'v2/messages/attachments/123123/123.jpg' }

  before do
    stub_request(:get, "#{path_with_creds}&format=jpg&id=123&sms_id=123123")
      .to_return(status: 200)
  end

  context 'with required params' do
    it { expect(call).to eq(response_with(status: 200, is_succeed: true)) }
  end

  context 'when error in params' do
    let(:params) { {} }
    let(:error) do
      "The property '#/' did not contain a required property of 'id'"
    end

    before do
      stub_request(:get, path_with_creds)
        .to_return(status: 200)
    end

    it_behaves_like 'with error'
  end
end
