require './lib/communicator.rb'

def start_calculator
  @communicator = Communicator.new
  @communicator.request_input
  @communicator.process_input
end

start_calculator
