require 'spec_helper'

describe ColorPalette do
  describe '.unidirectional' do
    it 'should return an array of colors starting with white and ending with the specified color' do
      colors = ColorPalette.unidirectional('#FF0000', 5)
      expect(colors.size).to be == 5
      expect(colors.first).to be == '#ffffff'
      expect(colors.last).to be == '#ff0000'
    end
  end 
end