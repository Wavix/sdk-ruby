# frozen_string_literal: true

require 'services/fields_validator'

describe Services::FieldsValidator do
  subject(:validator_error) do
    validator = described_class.new({ fields: fields, schema: schema })
    validator.call
    validator.error
  end

  shared_examples 'when fails with error' do
    it { expect(validator_error).to eq(error) }
  end

  shared_examples 'when succeed' do
    it { expect(validator_error).to be_nil }
  end

  context 'when required fields' do
    context 'when required fields with nested' do
      context 'when one level nesting' do
        let(:schema) do
          {
            type: 'object',
            properties: {
              name: { type: 'string' },
              surname: { type: 'string' },
              required: %i[name],
              metadata: {
                type: 'object',
                properties: {
                  age: { type: 'number' }
                },
                required: %i[age]
              }
            }
          }
        end

        context 'when succeed' do
          let(:fields) do
            { surname: 'Dudov', metadata: { age: 99 } }
          end

          it_behaves_like 'when succeed'
        end

        context 'when fails' do
          let(:fields) do
            { name: 'Dude', surname: 'Dudov', metadata: { country: 'USA' } }
          end
          let(:error) { "The property '#/metadata' did not contain a required property of 'age'" }

          it_behaves_like 'when fails with error'
        end
      end

      context 'when deep nested fields' do
        let(:schema) do
          {
            type: 'object',
            properties: {
              name: { type: 'string' },
              surname: { type: 'string' },
              metadata: {
                type: 'object',
                properties: {
                  age: { type: 'number' },
                  birth_place: {
                    type: 'object',
                    properties: {
                      city: { type: 'string' },
                      country: { type: 'string' }
                    },
                    required: %i[city country]
                  }
                },
                required: %i[age]
              }
            },
            required: %i[name]
          }
        end

        context 'when fails without nested key' do
          let(:fields) do
            {
              name: 'Dude',
              surname: 'Dudov',
              metadata: { birth_place: { city: 'Hawai', country: 'USA' } }
            }
          end

          let(:error) { "The property '#/metadata' did not contain a required property of 'age'" }

          it_behaves_like 'when fails with error'
        end

        context 'when fails without deep nested key' do
          let(:fields) do
            {
              name: 'Dude',
              surname: 'Dudov',
              metadata: { age: 31, birth_place: { city: 'Hawai' } }
            }
          end
          let(:error) do
            "The property '#/metadata/birth_place' " \
            "did not contain a required property of 'country'"
          end

          it_behaves_like 'when fails with error'
        end

        context 'when fails without not nested' do
          let(:fields) do
            {
              surname: 'Dudov',
              metadata: {
                age: 31, birth_place: { city: 'Hawai', country: 'USA' }
              }
            }
          end
          let(:error) { "The property '#/' did not contain a required property of 'name'" }

          it_behaves_like 'when fails with error'
        end

        context 'when succeed' do
          let(:fields) do
            {
              name: 'Dude',
              surname: 'Dudov',
              metadata: {
                age: 31, birth_place: { city: 'Hawai', country: 'USA' }
              }
            }
          end

          it_behaves_like 'when succeed'
        end
      end
    end
  end

  context 'when fields type' do
    context 'when fields with nested' do
      context 'when one level nesting' do
        let(:schema) do
          {
            type: 'object',
            properties: {
              id: { type: 'number' },
              metadata: {
                type: 'object',
                properties: {
                  type: { type: 'string' }
                }
              }
            }
          }
        end

        context 'when succeed' do
          let(:fields) { { id: 123, metadata: { type: 'sipcall' } } }

          it_behaves_like 'when succeed'
        end

        context 'when fails' do
          let(:fields) { { id: 123, metadata: { type: 111 } } }
          let(:error) do
            "The property '#/metadata/type' of type integer " \
            'did not match the following type: string'
          end

          it_behaves_like 'when fails with error'
        end
      end

      context 'when deep level nesting' do
        let(:schema) do
          {
            type: 'object',
            properties: {
              id: { type: 'number' },
              metadata: {
                type: 'object',
                properties: {
                  type: { type: 'string' },
                  details: {
                    type: 'object',
                    properties: {
                      transcription: {
                        type: 'object',
                        properties: {
                          uuid: { type: 'string' }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        end

        context 'when succeed' do
          let(:fields) do
            {
              id: 123,
              metadata: {
                type: 'sipcall',
                details: {
                  transcription: { uuid: 'unique' }
                }
              }
            }
          end

          it_behaves_like 'when succeed'
        end

        context 'when fails' do
          let(:fields) do
            {
              id: 123,
              metadata: {
                type: 'sipcall',
                details: {
                  transcription: { uuid: 111 }
                }
              }
            }
          end
          let(:error) do
            "The property '#/metadata/details/transcription/uuid' of type integer " \
            'did not match the following type: string'
          end

          it_behaves_like 'when fails with error'
        end
      end
    end

    context 'when fields without nested' do
      let(:schema) do
        {
          type: 'object',
          properties: {
            uuid: { type: 'string' },
            type: { type: 'string' }
          }
        }
      end

      context 'when succeed' do
        let(:fields) { { uuid: 'unique', type: 'sipcall' } }

        it_behaves_like 'when succeed'
      end

      context 'when fails' do
        let(:fields) { { uuid: 111, type: 'sipcall' } }
        let(:error) do
          "The property '#/uuid' of type integer did not match the following type: string"
        end

        it_behaves_like 'when fails with error'
      end
    end
  end

  context 'when fields inclusion' do
    context 'when inclusion fields with nested' do
      context 'when one level nesting' do
        let(:schema) do
          {
            type: 'object',
            properties: {
              from: { type: 'string' },
              to: { type: 'string' },
              metadata: {
                type: 'object',
                properties: {
                  dirrection: { enum: %w[inbound outbound] }
                }
              }
            }
          }
        end

        context 'when succeed' do
          let(:fields) do
            {
              to: '1234567890',
              from: '0987654321',
              metadata: { dirrection: 'inbound' }
            }
          end

          it_behaves_like 'when succeed'
        end

        context 'when fails' do
          let(:fields) do
            {
              to: '1234567890',
              from: '0987654321',
              metadata: { dirrection: 'all' }
            }
          end
          let(:error) do
            "The property '#/metadata/dirrection' value \"all\" " \
            'did not match one of the following values: inbound, outbound'
          end

          it_behaves_like 'when fails with error'
        end
      end

      context 'when deep level nesting' do
        let(:schema) do
          {
            type: 'object',
            properties: {
              from: { type: 'string' },
              to: { type: 'string' },
              metadata: {
                type: 'object',
                properties: {
                  details: {
                    type: 'object',
                    properties: {
                      dirrection: { enum: %w[inbound outbound] }
                    }
                  }
                }
              }
            }
          }
        end

        context 'when succeed' do
          let(:fields) do
            {
              to: '1234567890',
              from: '0987654321',
              metadata: { details: { dirrection: 'inbound' } }
            }
          end

          it_behaves_like 'when succeed'
        end

        context 'when fails' do
          let(:error) do
            "The property '#/metadata/details/dirrection' value \"all\" "\
            'did not match one of the following values: inbound, outbound'
          end
          let(:fields) do
            {
              to: '1234567890',
              from: '0987654321',
              metadata: { details: { dirrection: 'all' } }
            }
          end

          it_behaves_like 'when fails with error'
        end
      end
    end

    context 'when inclusion fields without nested' do
      let(:schema) do
        {
          type: 'object',
          properties: {
            to: { type: 'string' },
            dirrection: { enum: %w[inbound outbound] }
          }
        }
      end

      context 'when succeed' do
        let(:fields) { { to: '1234567890', dirrection: 'inbound' } }

        it_behaves_like 'when succeed'
      end

      context 'when fails' do
        let(:error) do
          "The property '#/dirrection' value \"all\" did not match one of the following values: " \
          'inbound, outbound'
        end
        let(:fields) { { to: '1234567890', dirrection: 'all' } }

        it_behaves_like 'when fails with error'
      end
    end
  end
end
