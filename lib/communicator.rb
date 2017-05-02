# A CLI class that could be expanded upon to introduce a TCPServer, or routes in the Rails sense, or an API...
# Hence, the vague name. :-)

require './lib/calculation_controller'

class Communicator
  REQUEST_INPUT = "input expression > "
  INVALID_ENTRY = "invalid entry: try again\n"
  GOODBYE = "Goodbye, world!\n"
  STOP = "q"
  CLEAR = "clear"
  USER_INSTRUCTIONS = "Type \'clear\' to reset your calculation and \'q\' to quit.\n"
  VALID_ENTRIES = '.+-/* 0123456789'.split('').push(STOP, CLEAR)

  def start
    send USER_INSTRUCTIONS
    until stopped? do
      request = request_input
      respond(request)
    end
  end

  def stopped?
    !!@stopped
  end

  def request_input
    message = request
    if !message
      puts
      message = STOP
    end
    message.chomp
  end

  def respond(request)
    if request.strip.empty?
    elsif !valid?(request)
      send(INVALID_ENTRY)
    elsif request == STOP
      stop
      send(GOODBYE)
    elsif request == CLEAR
      calculation_controller.reset
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
    send(REQUEST_INPUT)
    gets
  end

  def send(data)
    print data
  end

  def stop
    @stopped = true
  end

  def valid?(request)
    VALID_ENTRIES.include?(request) ||
    request.chars.all? do |char|
      VALID_ENTRIES.include?(char)
    end
  end
end
