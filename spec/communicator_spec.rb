require 'spec_helper'

describe Communicator do
  let(:communicator) { Communicator.new }
  let(:stop_request) { 'q' }

  def capture_output(&blk)
    old = $stdout
    $stdout = fake = StringIO.new
    blk.call
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
      expect(communicator).to receive(:process_input).exactly(2).times
      communicator.start
    end
  end

  describe '#request_input' do
    before :each do
      mock_user_input("user input\n")
    end

    it 'tells the user the communicator is expecting input' do
      message = capture_output { communicator.request_input }
      expect(message).to eql 'input expression > '
    end

    it 'returns the request from the user' do
      silence_output
      expect(communicator).to receive(:gets)
      communicator.request_input
    end

    it 'interprets CTRL-D as a stop request and goes to new line' do
      silence_output
      mock_user_input(nil) # nil is effectively end-of-file (CTRL-D)
      expect(communicator).to receive(:puts).with('')
      expect(communicator.request_input).to eql stop_request
    end

    it 'continues to request input if the user enters whitespace' do
      silence_output
      mock_user_input("\n")
      mock_user_input("something else")
      expect(communicator.request_input).to eql "something else"
    end
  end

  describe '#process_input' do
    describe 'when the user sends a stop request' do
      it 'sends the goodbye response' do
        message = capture_output { communicator.process_input(stop_request) }
        expect(message).to eql "goodbye, world!\n"
      end

      it 'stops communicating with the user' do
        silence_output
        communicator.process_input(stop_request)
        expect(communicator.stopped?).to be true
      end
    end

    describe 'when the user sends an invalid request' do
      let(:possible_characters) { (0..255).to_a.map { |int| int.chr } }
      let(:valid_characters) { ' .+-/*0123456789'.split('').push(stop_request) }
      let(:invalid_characters) { possible_characters - valid_characters }

      it 'sends the invalid entry response' do
        invalid_characters.each do |invalid_char|
          message = capture_output { communicator.process_input(invalid_char) }
          expect(message).to eql "invalid entry: calculation aborted\n"
        end
      end
    end

    describe 'when the user sends a valid request' do
      it 'gets the response from the CalculationController' do
        silence_output
        expect_any_instance_of(CalculationController)
          .to receive(:calculate)
          .with('42')
        communicator.process_input('42')
      end

      it 'sends the response to the user' do
        allow_any_instance_of(CalculationController)
          .to receive(:calculate).and_return('result')
        message = capture_output { communicator.process_input('42') }
        expect(message).to eql "result\n"
      end
    end
  end
end
