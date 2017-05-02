require 'spec_helper'

describe Calculation do
  let(:calculation) { Calculation.new }

  describe '#input' do
    it 'adds operations to its elements' do
      calculation.input('+')
      calculation.input('-')
      calculation.input('*')
      calculation.input('/')
      operations = calculation.data
      expect(operations[0].command).to eql '+'
      expect(operations[1].command).to eql '-'
      expect(operations[2].command).to eql '*'
      expect(operations[3].command).to eql '/'
    end

    it 'adds numbers as floats to its elements' do
      calculation.input('3')
      calculation.input(4)
      calculation.input('5.1')
      expect(calculation.data).to eql [3.0, 4.0, 5.1]
    end
  end

  describe '#compute' do
    describe 'operations' do
      it 'adds numbers' do
        calculation.input(4.0)
        calculation.input(5.0)
        calculation.input('+')
        expect(calculation.compute).to eql 9.0
      end

      it 'subtracts numbers' do
        calculation.input(3.0)
        calculation.input(4.5)
        calculation.input('-')
        expect(calculation.compute).to eql -1.5
      end

      it 'multiplies numbers' do
        calculation.input(2.0)
        calculation.input(4.5)
        calculation.input('*')
        expect(calculation.compute).to eql 9.0
      end

      it 'divides numbers' do
        calculation.input(9.5)
        calculation.input(2.0)
        calculation.input('/')
        expect(calculation.compute).to eql 4.75
      end

      it 'divides by 0 and returns Infinity' do # as does Ruby Float
        calculation.input(5.0)
        calculation.input(0.0)
        calculation.input('/')
        expect(calculation.compute).to eql Float::INFINITY
      end
    end

    describe 'when the last entry was a number' do
      it 'returns the last number entered' do
        calculation.input(4.0)
        calculation.input(5.0)
        calculation.input('+')
        calculation.input(3.0)
        expect(calculation.compute).to eql 3.0
      end
    end

    describe 'when it needs more operations to compute the entire equation' do
      it 'returns the most it can compute' do
        calculation.input(1.0)
        calculation.input(2.0)
        calculation.input(3.0)
        calculation.input('+')
        expect(calculation.compute).to eql 5.0
        calculation.input('+')
        expect(calculation.compute).to eql 6.0
      end
    end

    describe 'when it was not given enough numbers for its operations' do
      it 'fails to compute' do
        calculation.input(4.0)
        calculation.input('/')
        expect{ calculation.compute }.to raise_error(CalculationError)
      end
    end

    describe 'multiple operations' do
      it 'returns the sequential execution of operations' do
        calculation.input(4.0)
        expect(calculation.compute).to eql 4.0
        calculation.input(5.0)
        expect(calculation.compute).to eql 5.0
        calculation.input('+')
        expect(calculation.compute).to eql 9.0
        calculation.input(3.0)
        expect(calculation.compute).to eql 3.0
        calculation.input('*')
        expect(calculation.compute).to eql 27.0
      end

      it 'respects the RPN order of operations by applying operations to the sequentially nearest operands' do
        # Example from https://en.wikipedia.org/wiki/Reverse_Polish_notation
        calculation.input(5)
        calculation.input(1)
        calculation.input(2)
        calculation.input('+')
        calculation.input(4)
        calculation.input('*')
        calculation.input('+')
        calculation.input(3)
        calculation.input('-')
        expect(calculation.compute).to eql 14.0
      end
    end
  end
end
