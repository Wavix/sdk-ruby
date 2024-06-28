# frozen_string_literal: true

shared_context 'cdrs common search' do
  subject(:call) { described_class.new(query).call }

  include_context 'with creds'

  let(:path) { 'v1/cdr' }
  let(:query) do
    {
      type: type,
      from_search: '1234567890',
      to_search: '0987654321',
      page: 2,
      per_page: 10,
      disposition: 'disposition',
      uuid: 'uuid',
      sip_trunk: 'sip_trunk',
      from: from,
      to: to
    }
  end
  let(:formatted_query) { query }
  let(:type) { 'placed' }
  let(:from) { DateTime.parse('2023-01-01') }
  let(:to) { DateTime.parse('2024-01-01') }

  shared_examples 'when succeed' do
    it { expect(call).to eq(response_with(status: 200, is_succeed: true)) }
  end

  context 'without query' do
    let(:query) { {} }
    let(:error) { "The property '#/' did not contain a required property of 'from'" }

    it_behaves_like 'with error'
  end

  context 'when all valid' do
    let(:formatted_query) do
      query.merge(from: from.strftime('%Y-%m-%d'), to: to.strftime('%Y-%m-%d'))
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
    it_behaves_like 'when date invalid', 'from'
  end

  context 'when to_date invalid' do
    it_behaves_like 'when date invalid', 'to'
  end

  context 'when type invalid' do
    let(:error) do
      "The property '#/type' value " \
      '"invalid" did not match one of the following values: placed, received'
    end
    let(:type) { 'invalid' }

    it_behaves_like 'with error'
  end
end
