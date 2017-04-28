require 'spec_helper'

describe CalculationController do
  let(:controller) { CalculationController.new }

  describe '#calculate' do
    it 'returns the calculation result (e.g., view)' do
      view = controller.calculate('42')
      expect(view).to eql "result: 42"
    end
  end
end
