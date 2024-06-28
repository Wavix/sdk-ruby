# frozen_string_literal: true

describe WavixApi::V1::Call::Recordings::Search, type: :service do
  subject(:call) { described_class.new(query).call }

  include_context 'with creds'

  let(:query) do
    {
      from_date: from_date,
      to_date: to_date,
      from_time: from_time,
      to_time: to_time,
      from: from,
      to: to,
      call_uuid: call_uuid,
      sip_trunks: sip_trunks,
      dids: dids
    }
  end
  let(:formatted_query) { query }
  let(:only_digits_regexp) { '\'^\d+(,\d+)*$\'' }
  let(:path) { 'v1/recordings' }
  let(:from_date) { DateTime.parse('2023.01.01') }
  let(:to_date) { DateTime.parse('2024.01.01') }
  let(:from_time) { DateTime.parse('2023.01.01T01:01:01.000') }
  let(:to_time) { DateTime.parse('2024.01.01T01:01:01.000') }
  let(:from) { '1234567890' }
  let(:to) { '987654321' }
  let(:call_uuid) { '1234-uuid' }
  let(:sip_trunks) { %w[trunk1 trunk2] }
  let(:dids) { %w[1234 5678] }

  shared_context 'when succeed' do
    before do
      stub_request(:get, path_with_creds).with(query: formatted_query).to_return(status: 200)
    end

    it { expect(call).to eq(response_with(status: 200, is_succeed: true)) }
  end

  context 'without query' do
    let(:query) { {} }

    it_behaves_like 'when succeed'
  end

  context 'when all valid' do
    let(:formatted_query) do
      query.merge(
        from_date: from_date.strftime('%Y.%m.%d'),
        from_time: from_time.strftime('%Y.%m.%dTT%H:%M:%S.000'),
        to_date: to_date.strftime('%Y.%m.%d'),
        to_time: to_time.strftime('%Y.%m.%dTT%H:%M:%S.000')
      )
    end

    it_behaves_like 'when succeed'
  end

  shared_context 'when date invalid' do |field|
    context "when #{field} invalid" do
      let(field) { 'invalid' }

      it_behaves_like 'when invalid date format', field
    end

    context "when #{field} in invalid format" do
      let(field) { '2023.01.01' }

      it_behaves_like 'when invalid date format', field
    end
  end

  context 'when from_date invalid' do
    it_behaves_like 'when date invalid', 'from_date'
  end

  context 'when to_date invalid' do
    it_behaves_like 'when date invalid', 'to_date'
  end

  shared_context 'when datetime invalid' do |field|
    context "when #{field} invalid" do
      let(field) { 'invalid' }

      it_behaves_like 'when invalid date format', field
    end

    context "when #{field} in invalid format" do
      let(field) { '2023.01.01T01:01:01.000' }

      it_behaves_like 'when invalid date format', field
    end
  end

  context 'when from_time invalid' do
    it_behaves_like 'when datetime invalid', 'from_time'
  end

  context 'when to_time invalid' do
    it_behaves_like 'when datetime invalid', 'to_time'
  end

  shared_context 'when number invalid' do |field|
    context "when #{field} invalid" do
      let(field) { 'invalid' }

      it_behaves_like 'when invalid digits format', "#/#{field}", 'invalid'
    end

    context "when #{field} with invalid format" do
      let(field) { 'invalid1232' }

      it_behaves_like 'when invalid digits format', "#/#{field}", 'invalid1232'
    end
  end

  context 'when from invalid' do
    it_behaves_like 'when number invalid', 'from'
  end

  context 'when to invalid' do
    it_behaves_like 'when number invalid', 'to'
  end

  context 'when call_uuid is invalid' do
    let(:call_uuid) { 12_345 }
    let(:error) do
      'The property \'#/call_uuid\' of type integer did not match the following type: string'
    end

    it_behaves_like 'with error'
  end

  context 'when sip_trunks are invalid' do
    context 'when with invalid item' do
      let(:sip_trunks) { ['invalid', '1234', 1234] }
      let(:error) do
        'The property \'#/sip_trunks/2\' of type integer did not match the following type: string'
      end

      it_behaves_like 'with error'
    end

    context 'when with null item' do
      let(:sip_trunks) { ['1234', nil] }
      let(:error) do
        'The property \'#/sip_trunks/1\' of type null did not match the following type: string'
      end

      it_behaves_like 'with error'
    end
  end

  context 'when dids are invalid' do
    context 'when with invalid item' do
      let(:dids) { %w[invalid 1234] }

      it_behaves_like 'when invalid digits format', '#/dids/0', 'invalid'
    end

    context 'when with null item' do
      let(:dids) { ['1234', nil] }
      let(:error) do
        'The property \'#/dids/1\' of type null did not match the following type: string'
      end

      it_behaves_like 'with error'
    end

    context 'when with invalid integer item' do
      let(:dids) { ['1234', 1234] }
      let(:error) do
        'The property \'#/dids/1\' of type integer did not match the following type: string'
      end

      it_behaves_like 'with error'
    end
  end
end
