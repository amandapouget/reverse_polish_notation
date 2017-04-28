require 'spec_helper'

describe Calculation do
  let(:element) { '4' }
  let(:calculation) { Calculation.new(element) }

  it 'knows the elements to compute' do
    expect(calculation.elements).to eql [element]
  end
end
