require 'spec_helper'

describe CalculationController do
  let(:controller) { CalculationController.new }

  describe '#calculate' do
    describe 'when the calculation can compute the data' do
      it 'returns the result view with the computation' do
        view = controller.calculate('4 5 +')
        expect(view).to eql "result: 9.0\n"
      end
    end

    describe 'when computing the calculation throws an error' do
      it 'returns the result view with the error message' do
        view = controller.calculate('4 *')
        expect(view).to include 'wrong number of arguments'
      end

      it 'resets itself so the user can try again' do
        expect(controller).to receive(:reset)
        view = controller.calculate('4 *')
      end
    end
  end

  describe '#reset' do
    it 'forgets the current calculation' do
      controller.calculate('42')
      controller.reset
      expect(controller.calculation).to be nil
    end
  end
end
