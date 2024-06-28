# frozen_string_literal: true

describe WavixApi::V1::Papers::Create, type: :service do
  subject(:call) { described_class.new(params).call }

  include_context 'with creds'

  let(:path) { 'v1/mydids/papers' }
  let(:params) do
    {
      did_ids: did_ids,
      doc_id: 1,
      doc_attachment: file
    }
  end
  let(:did_ids) { '1,2' }
  let(:file) do
    File.open(File.join(__dir__, '..', '..', '..', '..', 'support', 'files', 'test.jpg'))
  end
  let(:expected_body) do
    { doc_attachment: Faraday::Multipart::FilePart.new(file.path, 'image/jpeg') }
  end

  shared_context 'when succeed' do
    before do
      stub_request(:post, /#{full_path}.*/).to_return(status: 200)
      call
    end

    it { expect(call).to eq(response_with(status: 200, is_succeed: true)) }

    it do
      expect(WebMock).to(have_requested(:post, /#{full_path}.*/).with do |r|
        expect(r.headers['Content-Disposition']).to eq('form-data')
        expect(r.body).to include('test.jpg')
      end)
    end
  end

  context 'without params' do
    let(:params) { {} }
    let(:error) do
      "The property '#/' did not contain a required property of 'did_ids'"
    end

    it_behaves_like 'with error'
  end

  context 'with params' do
    context 'when invalid did_ids format' do
      let(:did_ids) { '1,,' }

      it_behaves_like 'when invalid lits of digits format', '#/did_ids', '1,,'
    end

    context 'when invalid did_ids value' do
      let(:did_ids) { 1234 }

      it_behaves_like 'when did not match type string', '#/did_ids', 'integer'
    end

    context 'when valid argument value' do
      it_behaves_like 'when succeed'
    end
  end
end
