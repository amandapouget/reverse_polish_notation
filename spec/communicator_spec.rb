require 'spec_helper'

describe Communicator do
  let(:communicator) { Communicator.new }

  def capture_output(&blk)
    old = $stdout
    $stdout = fake = StringIO.new
    blk.call
    fake.string
  ensure
    $stdout = old
  end

  describe '#request_input' do
    it 'indicates the communicator is expecting input' do
      message = capture_output { communicator.request_input }
      expect(message).to eql 'input expression > '
    end
  end

  describe '#process_input' do
    let(:silence_output) { allow(communicator).to receive(:puts) }
    let(:mock_user_input) do
      allow(communicator).to receive(:gets).and_return("user input\n")
    end

    before do
      mock_user_input
    end

    it 'receives the request from the user' do
      silence_output
      expect(communicator).to receive(:gets)
      communicator.process_input
    end

    describe 'when the user sends the request' do
      it 'sends the message to the CalculationController' do
        silence_output
        expect_any_instance_of(CalculationController)
          .to receive(:calculate)
          .with('user input')
        communicator.process_input
      end

      it 'sends the response to the user' do
        allow_any_instance_of(CalculationController)
          .to receive(:calculate).and_return('result')
        message = capture_output { communicator.process_input }
        expect(message).to eql "result\n"
      end
    end
  end
end
