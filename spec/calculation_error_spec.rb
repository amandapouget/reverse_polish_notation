require 'spec_helper'

describe CalculationError do
  let(:error) { StandardError.new('something went wrong') }
  let(:operation) { Operation.new('+') }
  let(:operands) { [1.0, 2.0] }
  let(:calculation_error) { CalculationError.new(error, operation, operands) }

  describe '#initialize' do
    it 'augments a standard error with a more specific message' do
      message = calculation_error.message
      expect(message).to include operands.to_s
      expect(message).to include operation.command
      expect(message).to include error.message
      expect{ raise calculation_error }.to raise_error CalculationError
    end
  end
end
