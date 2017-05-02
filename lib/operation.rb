class Operation
  attr_reader :num_operands, :command

  def initialize(command, num_operands = 2)
    @command = command
    @num_operands = num_operands
  end

  def calculate(operands)
    operands.shift.send(command, *operands)
  end
end
