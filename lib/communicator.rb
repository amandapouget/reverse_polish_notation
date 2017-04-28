# A CLI class that could be expanded upon to introduce a TCPServer, or routes in the Rails sense, or an API...
# Hence, the vague name. :-)

require './lib/calculation_controller'

class Communicator
  def calculation_controller
    @calculation_controller ||= CalculationController.new
  end

  def request_input
    print 'input expression > '
  end

  def process_input
    request = gets.chomp
    view = calculation_controller.calculate(request)
    response(view)
  end

private
  def request
    gets.chomp
  end

  def response(data)
    puts data
  end
end
