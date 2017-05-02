require 'spec_helper'

describe Communicator do
  let(:communicator) { Communicator.new }

  def capture_output(&block) # snippet from an Academy project
    old = $stdout
    $stdout = fake = StringIO.new
    block.call
    fake.string
  ensure
    $stdout = old
  end

  def silence_output
    allow(communicator).to receive(:puts)
    allow(communicator).to receive(:print)
  end

  def mock_user_input(text)
    mock = allow(communicator).to receive(:gets).and_return(text)
  end

  describe '#start' do
    it 'requests and processes input until stopped' do
      silence_output
      allow(communicator).to receive(:stopped?).and_return(false, false, true)
      expect(communicator).to receive(:request_input).exactly(2).times
      expect(communicator).to receive(:respond).exactly(2).times
      communicator.start
    end

    it 'sends initial user instructions' do
      message = capture_output {
        allow(communicator).to receive(:stopped?).and_return(true)
        communicator.start
      }
      expect(message).to eql Communicator::USER_INSTRUCTIONS
    end
  end

  describe '#request_input' do
    before :each do
      mock_user_input("user input\n")
    end

    it 'tells the user the communicator is expecting input' do
      message = capture_output { communicator.request_input }
      expect(message).to eql Communicator::REQUEST_INPUT
    end

    it 'returns the request from the user' do
      silence_output
      expect(communicator).to receive(:gets)
      communicator.request_input
    end

    it 'interprets CTRL-D as a stop request' do
      silence_output
      mock_user_input(nil) # nil is effectively end-of-file (CTRL-D)
      expect(communicator).to receive(:puts).with(no_args)
      expect(communicator.request_input).to eql Communicator::STOP
    end
  end

  describe '#respond' do
    describe 'when the user enters whitespace' do
      it 'does nothing' do
        message = capture_output { communicator.respond('  ') }
        expect(message).to eql ''
      end
    end

    describe 'when the user sends an invalid request' do
      let(:possible_characters) { (19..255).to_a.map { |int| int.chr } }
      let(:valid_characters) { Communicator::VALID_ENTRIES }
      let(:invalid_characters) { possible_characters - valid_characters }

      it 'sends the invalid entry response' do
        invalid_characters.each_with_index do |invalid_char, index|
          message = capture_output { communicator.respond(invalid_char) }
          expect(message).to eql Communicator::INVALID_ENTRY
        end
      end
    end

    describe 'when the user sends a stop request' do
      it 'sends the goodbye response' do
        message = capture_output { communicator.respond(Communicator::STOP) }
        expect(message).to eql Communicator::GOODBYE
      end

      it 'stops communicating with the user' do
        silence_output
        communicator.respond(Communicator::STOP)
        expect(communicator.stopped?).to be true
      end
    end

    describe 'when the user sends a request to clear entries' do
      it 'resets the CalculationController' do
        silence_output
        expect_any_instance_of(CalculationController).to receive(:reset)
        communicator.respond(Communicator::CLEAR)
      end
    end

    describe 'when the user sends a valid request' do
      it 'gets the response from the CalculationController' do
        silence_output
        expect_any_instance_of(CalculationController)
          .to receive(:calculate)
          .with('42')
        communicator.respond('42')
      end

      it 'sends the response to the user' do
        allow_any_instance_of(CalculationController)
          .to receive(:calculate).and_return('result')
        message = capture_output { communicator.respond('42') }
        expect(message).to eql "result"
      end
    end
  end
end
