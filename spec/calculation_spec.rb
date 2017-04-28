require 'spec_helper'

describe Calculation do
  let(:calculation) { Calculation.new() }

  describe '#add_data' do
    it 'adds operations to its elements' do
      calculation.add_data('+')
      calculation.add_data('-')
      calculation.add_data('*')
      calculation.add_data('/')
      expect(calculation.elements).to eql '+-*/'.split('')
    end

    it 'adds numbers as floats to its elements' do
      calculation.add_data('3')
      calculation.add_data(4.0)
      calculation.add_data('5.1')
      expect(calculation.elements).to eql [3.0, 4.0, 5.1]
    end
  end

  describe '#compute' do
    describe 'adding numbers' do
      it 'returns their sum' do
        calculation.add_data(4.0)
        calculation.add_data(5.0)
        calculation.add_data('+')
        expect(calculation.compute).to eql 9.0
      end

      it 'returns a correct sum with negative numbers' do
        calculation.add_data(-2.0)
        calculation.add_data(-10.0)
        calculation.add_data('+')
        expect(calculation.compute).to eql -12.0
      end
    end

    describe 'no operation' do
      it 'returns the last number entered' do
        calculation.add_data(4.0)
        calculation.add_data(5.0)
        expect(calculation.compute).to eql 5.0
      end
    end

    describe 'multiple operations' do
      # Per example in the exercise docs, it does not respect the order of operations
      it 'returns the sequential execution of operations' do
        calculation.add_data(4.0)
        calculation.add_data(5.0)
        calculation.add_data('+')
        calculation.add_data(3.0)
        calculation.add_data('*')
        expect(calculation.compute).to eql 27.0
      end

      describe 'no final operation' do
        it 'returns the last number entered' do
          calculation.add_data(4.0)
          calculation.add_data(5.0)
          calculation.add_data('+')
          calculation.add_data(3.0)
          expect(calculation.compute).to eql 3.0
        end
      end
    end
  end
end
