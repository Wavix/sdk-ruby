# frozen_string_literal: true

module RequestHelpers
  include WavixApi::HTTPMethods

  def response_with(status: 200, body: {}, is_succeed: true)
    Response.new(status, '', body.empty? ? '' : body.to_json, body, is_succeed)
  end

  shared_examples 'with error' do
    it { expect { call }.to raise_error(::WavixApi::ValidationError, error) }
  end

  shared_context 'when ID is not defined' do |is_uuid|
    let(:id_type) { is_uuid ? 'string' : 'integer' }
    let(:error) { "The property '#/id' of type null did not match the following type: #{id_type}" }

    it_behaves_like 'with error'
  end

  shared_context 'when invalid date format' do |key|
    let(:error) { "Fields #{[key.to_sym]} must be a DateTime" }

    it_behaves_like 'with error'
  end

  shared_context 'when invalid regexp format' do |key, value, regexp|
    let(:error) do
      "The property \'#{key}\' value \"#{value}\" did not match the regex " + regexp
    end

    it_behaves_like 'with error'
  end

  shared_examples 'when invalid digits format' do |key, value|
    it_behaves_like 'when invalid regexp format', key, value, '\'(?-mix:^\d+$)\''
  end

  shared_examples 'when invalid lits of digits format' do |key, value|
    it_behaves_like 'when invalid regexp format', key, value, '\'(?-mix:^\d+(,\d+)*$)\''
  end

  shared_context 'when did not match format' do |key, type, expected_type|
    let(:error) do
      "The property '#{key}' of type #{type} did not match the following type: #{expected_type}"
    end

    it_behaves_like 'with error'
  end

  shared_examples 'when did not match type integer' do |key, type|
    it_behaves_like 'when did not match format', key, type, 'integer'
  end

  shared_examples 'when did not match type string' do |key, type|
    it_behaves_like 'when did not match format', key, type, 'string'
  end

  shared_context 'when required field missing' do |key|
    let(:error) do
      "The property '#/' did not contain a required property of '#{key}'"
    end

    it_behaves_like 'with error'
  end
end
