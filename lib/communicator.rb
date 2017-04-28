# A CLI class that could be expanded upon to introduce a TCPServer, or routes in the Rails sense, or an API...
# Hence, the vague name. :-)

require './lib/calculation_controller'

class Communicator
  REQUEST_INPUT = 'input expression > '
  INVALID_ENTRY = 'invalid entry: calculation aborted'
  GOODBYE = 'goodbye, world!'
  STOP_REQUEST = 'q'
  CLEAR = 'clear'
  private_constant :REQUEST_INPUT
  private_constant :INVALID_ENTRY
  private_constant :GOODBYE
  private_constant :STOP_REQUEST
  private_constant :CLEAR

  def start
    send 'Type \'clear\' to reset your calculation.'
    until stopped? do
      request = request_input
      process_input(request)
    end
  end

  def stopped?
    !!@stopped
  end

  def request_input
    message = request
    if !message
      send
      message = STOP_REQUEST
    end
    message = message.chomp
    request_input if message == ""
    message
  end

  def process_input(request)
    if request == STOP_REQUEST
      stop
      send(GOODBYE)
    elsif request == CLEAR
      calculation_controller.reset
    elsif !valid?(request)
      calculation_controller.reset
      send(INVALID_ENTRY)
    else
      calculation = calculation_controller.calculate(request)
      send(calculation)
    end
  end

private
  def calculation_controller
    @calculation_controller ||= CalculationController.new
  end

  def request
    print REQUEST_INPUT
    gets
  end

  def send(data = '')
    puts data
  end

  def stop
    @stopped = true
  end

  def valid?(request)
    valid_characters = ' .+-/*0123456789'.split('').push(STOP_REQUEST)
    request.chars.all? do |char|
      valid_characters.include?(char)
    end
  end
end
