require 'spec_helper'

describe Calculator do
  let(:calculator) { Calculator.new }

  def capture_output(&blk)
    old = $stdout
    $stdout = fake = StringIO.new
    blk.call
    fake.string
  ensure
    $stdout = old
  end

  def silence_output
    allow(calculator).to receive(:print)
  end

  def mock_user_input(text)
    allow(calculator).to receive(:gets).and_return(text)
  end

  describe '#get_input' do
    it 'indicates the calculator is expecting input' do
      mock_user_input('user input')
      message = capture_output { calculator.get_input }
      expect(message).to eql 'input expression > '
    end

    it 'takes input from the user' do
      silence_output
      mock_user_input('user input')
      expect(calculator.get_input).to eql 'user input'
    end

    it 'filters out the enter keystroke' do
     silence_output
     mock_user_input("user input\n")
     expect(calculator.get_input).to eql 'user input'
    end
  end
end
