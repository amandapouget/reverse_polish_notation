# 'C' in MVC... each method returns a 'View'

require './lib/calculation'

class CalculationController
  attr_reader :calculation

  def calculate(element)
    @calculation = Calculation.new(element)
    result_view
  end

private
  def result_view
    "result: " + @calculation.elements[0]
  end
end
