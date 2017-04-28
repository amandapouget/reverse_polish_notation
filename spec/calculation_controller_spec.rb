require 'spec_helper'

describe CalculationController do
  let(:controller) { CalculationController.new }

  describe '#calculate' do
    describe 'when given a number' do
      it 'returns a float view of the number' do
        view = controller.calculate('42')
        expect(view).to eql "result: 42.0"
      end
    end

    describe 'when given an operation' do
      it 'returns the calculation result view' do
        view = controller.calculate('4 5 +')
        expect(view).to eql "result: 9.0"
      end
    end
  end
    end
  end
end
