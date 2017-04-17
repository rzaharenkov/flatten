require_relative '../lib/flatten'

RSpec.describe Flatten do
  subject { described_class }

  shared_examples 'acts as flatten' do |method_name|
    context ".#{method_name}" do
      context 'when flat array given' do
        it 'returns the same array' do
          expect(subject.public_send(method_name, [1, 2, 3])).to eq([1, 2, 3])
        end
      end

      context 'when nested array given' do
        let(:array) { [1, 2, [[3, 4], 5], 6, 7, [8, [9, 10]]] }
        let(:expected_result) { [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] }

        it 'returns flattened array' do
          expect(subject.public_send(method_name, array)).to eq(expected_result)
        end
      end

      context 'empty array given' do
        it 'returns an empty array' do
          expect(subject.public_send(method_name, [])).to eq([])
        end
      end

      context 'when not array given' do
        it 'raises ArgumentError' do
          expect {
            subject.public_send(method_name, 42)
          }.to raise_error(ArgumentError)
        end
      end
    end
  end

  include_examples 'acts as flatten', :flatten
  include_examples 'acts as flatten', :reccursive_flatten
end
