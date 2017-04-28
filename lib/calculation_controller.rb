# 'C' in MVC... each method returns a 'View'

require './lib/calculation'

class CalculationController
  attr_reader :calculation

  def calculate(elements)
    @calculation ||= Calculation.new
    elements.split.each do |element|
      @calculation.add_data(element)
    end
    result_view
  end

private
  def result_view
    "result: " + @calculation.compute.to_s
  end
end
