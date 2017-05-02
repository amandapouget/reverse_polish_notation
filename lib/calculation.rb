require('./lib/calculation_error.rb')
require('./lib/operation.rb')

class Calculation
  attr_reader :data

  def initialize
    @data = []
  end

  def input(datum)
    if is_operation?(datum)
      @data.push(Operation.new(datum))
    else
      @data.push(datum.to_f)
    end
  end

  def compute(inputs = @data)
    return inputs.last if inputs.last.is_a?(Numeric)
    operation = next_operation(inputs)
    numbers = preceeding(operation, inputs)
    operands = numbers.pop(operation.num_operands)
    result = calculate(operation, operands)
    inputs = numbers.push(result).concat(following(operation, inputs))
    compute(inputs)
  end

private
  def is_operation?(datum)
    '+-/*'.split('').include?(datum)
  end

  def next_operation(data)
    data.find { |datum| datum.is_a?(Operation) }
  end

  def preceeding(operation, inputs)
    inputs[0...inputs.find_index(operation)]
  end

  def following(operation, inputs)
    start = inputs.find_index(operation) + 1
    inputs[start..-1] || []
  end

  def calculate(operation, operands)
    begin
      operation.calculate(operands.dup)
    rescue => e
      raise CalculationError.new(e, operation, operands)
    end
  end
end
