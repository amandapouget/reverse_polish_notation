class CalculationError < StandardError
  def initialize(error, operation, operands)
    message = "Error. Tried to compute: " + operation.command +
              " with: " + operands.to_s + " but got: " + error.message
    super(message)
  end
end
