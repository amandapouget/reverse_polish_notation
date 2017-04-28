class Calculation
  attr_reader :elements

  def initialize()
    @elements = []
  end

  def add_data(element)
    if is_operation(element)
      @elements.push(element)
    else
      @elements.push(element.to_f)
    end
  end

  def compute(elements = @elements)
    return elements.last if is_number(elements.last)
    operation = elements.find { |element| is_operation(element) }
    numbers = elements[0...elements.find_index(operation)]
    result = calculate(numbers, operation)

    remaining_elements = elements[(numbers.length + 1)..-1]
    return result if !remaining_elements
    compute([result].concat(remaining_elements))
  end

private
  def is_number(element)
    !is_operation(element)
  end

  def is_operation(element)
    '+-/*'.split('').include?(element)
  end

  def calculate(numbers, operation)
    numbers.reduce do |total = 0, number|
      total.send(operation, number)
    end
  end
end
