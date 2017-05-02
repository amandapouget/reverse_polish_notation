# 'C' in MVC... each method returns a 'View'

require './lib/calculation'

class CalculationController
  attr_reader :calculation

  def calculate(data)
    @calculation ||= Calculation.new
    input(data)
    result_view(computation)
  end

  def reset
    @calculation = nil
  end

private
  def input(data)
    data.split.each do |datum|
      @calculation.input(datum)
    end
  end

  def computation
    begin
      @calculation.compute.to_s
    rescue => e
      reset
      e.to_s
    end
  end

  def result_view(computation)
    "result: " + computation + "\n"
  end
end
