require 'spec_helper'

describe Operation do
  let(:command) { '-' }
  let(:operation) { Operation.new(command) }
  let(:operands) { [Object.new, Object.new, Object.new] }

  describe '#initialize' do
    it 'knows its command' do
      expect(operation.command).to eql '-'
    end

    it 'has a default number of operands for its command' do
      expect(operation.num_operands).to eql 2
    end

    it 'can have a different number of operands' do
      operation = Operation.new(command, 4)
      expect(operation.num_operands).to eql 4
    end
  end

  describe '#calculate' do
    it "returns the first operand's response to the command and other operands" do
      args = operands[1..-1]
      allow(operands[0]).to receive(command.to_sym).with(*args).and_return('42')
      expect(operation.calculate(operands)).to eql '42'
    end
  end
end
