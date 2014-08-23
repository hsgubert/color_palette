
module ColorPalette

  def self.unidirectional(end_color, palette_size, start_color="#ffffff", return_color_strings=true)
    start_color = ColorPalette::Color::RGB.from_string(start_color)
    end_color = ColorPalette::Color::RGB.from_string(end_color)

    delta_r = (end_color.r - start_color.r) / (palette_size - 1)
    delta_g = (end_color.g - start_color.g) / (palette_size - 1)
    delta_b = (end_color.b - start_color.b) / (palette_size - 1)

    palette = []
    palette_size.times do |i|
      color = ColorPalette::Color::RGB.from_increment_in_other_color(start_color, i*delta_r, i*delta_g, i*delta_b)
      palette << color 
    end

    if return_color_strings
      palette.map(&:to_s)
    else
      palette
    end
  end

end

require 'color_palette/version'
require 'color_palette/color/rgb'