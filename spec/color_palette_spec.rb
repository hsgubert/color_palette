require 'spec_helper'

describe ColorPalette do
  describe '.unidirectional' do
    it 'should return an array of colors starting with white and ending with the specified color' do
      colors = ColorPalette.unidirectional('#ff0000', 5)
      expect(colors.size).to be == 5
      expect(colors.first).to be == '#ffffff'
      expect(colors.last).to be == '#ff0000'
    end

    it 'should accept a color as start color' do
      colors = ColorPalette.unidirectional('#ff0000', 5, '#000000')
      expect(colors.size).to be == 5
      expect(colors.first).to be == '#000000'
      expect(colors.last).to be == '#ff0000'
    end

    it 'should accept many formats of color strings' do
      expect { ColorPalette.unidirectional('#ff0000', 5, '#000000') }.to_not raise_error
      expect { ColorPalette.unidirectional('#f00', 5, '#00F') }.to_not raise_error
      expect { ColorPalette.unidirectional('ff0000', 5, '000000') }.to_not raise_error
      expect { ColorPalette.unidirectional('f00', 5, '00F') }.to_not raise_error
    end
  end 
end