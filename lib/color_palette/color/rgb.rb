# Inspired by the work of 2005 Austin Ziegler (http://rubyforge.org/ruby-pdf/)

# An RGB colour object.
module ColorPalette::Color
  class RGB

    attr_accessor :r, :g, :b

    # Creates an RGB colour object from percentages 0..100.
    def self.from_percentages(r=0, g=0, b=0)
      from_fractions(r/100.0, g/100.0, b/100.0)
    end
    
    # Creates an RGB colour object from integer values 0..255.
    def self.from_integers(r=0, g=0, b=0)
      from_fractions(r/255.0, g/255.0, b/255.0)
    end

    # Creates an RGB colour object from fractional values 0..1.
    def self.from_fractions(r=0.0, g=0.0, b=0.0)
      color = ColorPalette::Color::RGB.new
      color.r = r
      color.g = g
      color.b = b
      color
    end

    # Creates an RGB color object from a hex string (e.g.,
    #
    #   Color::RGB.from_string("bef")
    #   Color::RGB.from_string("#bef")
    #   Color::RGB.from_string("#dabbec")
    #   Color::RGB.from_string("dabbec")
    def self.from_string(color_string)
      # remove hashtag if necessary
      color_string = color_string.gsub(%r{[#;]}, '')
      
      case color_string.size 
      when 3
        colors = color_string.scan(/[0-9A-Fa-f]/).map { |color_value| (color_value * 2).to_i(16) }
      when 6
        colors = color_string.scan(/[0-9A-Fa-f]{2}/).map { |color_value| color_value.to_i(16) }
      else
        raise ArgumentError
      end

      from_integers(*colors)
    end

    def self.from_increment_in_other_color(other_color, r_increment, g_increment, b_increment)
      color = from_fractions(other_color.r, other_color.g, other_color.b)
      color.r = color.r + r_increment
      color.g = color.g + g_increment
      color.b = color.b + b_increment
      color
    end

    # Compares the other colour to this one. This will report that two
    # RGB colours are equivalent if all component values are within 1e-4
    # (0.0001) of each other.
    def ==(other_color)
      # The other color will be converted to RGB before comparison. If there is no #to_rgb
      # conversion, this will raise an exception.
      other_color = other_color.to_rgb

      if other_color.is_a?(ColorPalette::Color::RGB)
        return ((@r - other_color.r).abs <= 1e-4) && 
          ((@g - other_color.g).abs <= 1e-4) && 
          ((@b - other_color.b).abs <= 1e-4)
      end

      return false
    end

    # Creates a black RGB colour object. Please use class methods from_* to create other colors.
    def initialize
      self.r = 0.0
      self.g = 0.0
      self.b = 0.0
    end

    def to_s
      r_integer = (r * 255).round
      r_integer = 255 if r_integer > 255

      g_integer = (g * 255).round
      g_integer = 255 if g_integer > 255

      b_integer = (b * 255).round
      b_integer = 255 if b_integer > 255

      "#%02x%02x%02x" % [ r_integer, g_integer, b_integer ]
    end

    def to_rgb
      self
    end

    # overload setters to garantee storing in floats and in range 0..1
    def r=(red)
      red = 1.0 if red > 1
      red = 0.0 if red < 0
      @r = red.to_f
    end

    def g=(green)
      green = 1.0 if green > 1
      green = 0.0 if green < 0
      @g = green.to_f
    end

    def b=(blue)
      blue = 1.0 if blue > 1
      blue = 0.0 if blue < 0
      @b = blue.to_f
    end

    # # Converts the RGB colour to CMYK. Most colour experts strongly suggest
    # # that this is not a good idea (some even suggesting that it's a very
    # # bad idea). CMYK represents additive percentages of inks on white
    # # paper, whereas RGB represents mixed colour intensities on a black
    # # screen.
    # #
    # # However, the colour conversion can be done. The basic method is
    # # multi-step:
    # #
    # # 1. Convert the R, G, and B components to C, M, and Y components.
    # #     c = 1.0 – r
    # #     m = 1.0 – g
    # #     y = 1.0 – b
    # # 2. Compute the minimum amount of black (K) required to smooth the
    # #    colour in inks.
    # #     k = min(c, m, y)
    # # 3. Perform undercolour removal on the C, M, and Y components of the
    # #    colours because less of each colour is needed for each bit of
    # #    black. Also, regenerate the black (K) based on the undercolour
    # #    removal so that the colour is more accurately represented in ink.
    # #     c = min(1.0, max(0.0, c – UCR(k)))
    # #     m = min(1.0, max(0.0, m – UCR(k)))
    # #     y = min(1.0, max(0.0, y – UCR(k)))
    # #     k = min(1.0, max(0.0, BG(k)))
    # #
    # # The undercolour removal function and the black generation functions
    # # return a value based on the brightness of the RGB colour.
    # def to_cmyk
    #   c = 1.0 - @r.to_f
    #   m = 1.0 - @g.to_f
    #   y = 1.0 - @b.to_f

    #   k = [c, m, y].min
    #   k = k - (k * brightness)

    #   c = [1.0, [0.0, c - k].max].min
    #   m = [1.0, [0.0, m - k].max].min
    #   y = [1.0, [0.0, y - k].max].min
    #   k = [1.0, [0.0, k].max].min

    #   Color::CMYK.from_fraction(c, m, y, k)
    # end

    # # Returns the YIQ (NTSC) colour encoding of the RGB value.
    # def to_yiq
    #   y = (@r * 0.299) + (@g *  0.587) + (@b *  0.114)
    #   i = (@r * 0.596) + (@g * -0.275) + (@b * -0.321)
    #   q = (@r * 0.212) + (@g * -0.523) + (@b *  0.311)
    #   Color::YIQ.from_fraction(y, i, q)
    # end

    # # Returns the HSL colour encoding of the RGB value.
    # def to_hsl
    #   min   = [ @r, @g, @b ].min
    #   max   = [ @r, @g, @b ].max
    #   delta = (max - min).to_f

    #   lum   = (max + min) / 2.0

    #   if delta <= 1e-5  # close to 0.0, so it's a grey
    #     hue = 0
    #     sat = 0
    #   else
    #     if (lum - 0.5) <= 1e-5
    #       sat = delta / (max + min).to_f
    #     else
    #       sat = delta / (2 - max - min).to_f
    #     end

    #     if @r == max
    #       hue = (@g - @b) / delta.to_f
    #     elsif @g == max
    #       hue = (2.0 + @b - @r) / delta.to_f
    #     elsif (@b - max) <= 1e-5
    #       hue = (4.0 + @r - @g) / delta.to_f
    #     end
    #     hue /= 6.0

    #     hue += 1 if hue < 0
    #     hue -= 1 if hue > 1
    #   end
    #   Color::HSL.from_fraction(hue, sat, lum)
    # end

    # # Mix the RGB hue with White so that the RGB hue is the specified
    # # percentage of the resulting colour. Strictly speaking, this isn't a
    # # darken_by operation.
    # def lighten_by(percent)
    #   mix_with(White, percent)
    # end

    # # Mix the RGB hue with Black so that the RGB hue is the specified
    # # percentage of the resulting colour. Strictly speaking, this isn't a
    # # darken_by operation.
    # def darken_by(percent)
    #   mix_with(Black, percent)
    # end

    # # Mix the mask colour (which must be an RGB object) with the current
    # # colour at the stated opacity percentage (0..100).
    # def mix_with(mask, opacity)
    #   opacity /= 100.0
    #   rgb = self.dup

    #   rgb.r = (@r * opacity) + (mask.r * (1 - opacity))
    #   rgb.g = (@g * opacity) + (mask.g * (1 - opacity))
    #   rgb.b = (@b * opacity) + (mask.b * (1 - opacity))

    #   rgb
    # end

    # # Returns the brightness value for a colour, a number between 0..1.
    # # Based on the Y value of YIQ encoding, representing luminosity, or
    # # perceived brightness.
    # #
    # # This may be modified in a future version of color-tools to use the
    # # luminosity value of HSL.
    # def brightness
    #   to_yiq.y
    # end

    # def to_grayscale
    #   Color::GrayScale.from_fraction(to_hsl.l)
    # end

    # alias to_greyscale to_grayscale

    # # Returns a new colour with the brightness adjusted by the specified
    # # percentage. Negative percentages will darken the colour; positive
    # # percentages will brighten the colour.
    # #
    # #   Color::RGB::DarkBlue.adjust_brightness(10)
    # #   Color::RGB::DarkBlue.adjust_brightness(-10)
    # def adjust_brightness(percent)
    #   percent /= 100.0
    #   percent += 1.0
    #   percent  = [ percent, 2.0 ].min
    #   percent  = [ 0.0, percent ].max

    #   hsl      = to_hsl
    #   hsl.l   *= percent
    #   hsl.to_rgb
    # end

    # # Returns a new colour with the saturation adjusted by the specified
    # # percentage. Negative percentages will reduce the saturation; positive
    # # percentages will increase the saturation.
    # #
    # #   Color::RGB::DarkBlue.adjust_saturation(10)
    # #   Color::RGB::DarkBlue.adjust_saturation(-10)
    # def adjust_saturation(percent)
    #   percent  /= 100.0
    #   percent  += 1.0
    #   percent  = [ percent, 2.0 ].min
    #   percent  = [ 0.0, percent ].max

    #   hsl      = to_hsl
    #   hsl.s   *= percent
    #   hsl.to_rgb
    # end

    # # Returns a new colour with the hue adjusted by the specified
    # # percentage. Negative percentages will reduce the hue; positive
    # # percentages will increase the hue.
    # #
    # #   Color::RGB::DarkBlue.adjust_hue(10)
    # #   Color::RGB::DarkBlue.adjust_hue(-10)
    # def adjust_hue(percent)
    #   percent  /= 100.0
    #   percent  += 1.0
    #   percent  = [ percent, 2.0 ].min
    #   percent  = [ 0.0, percent ].max

    #   hsl      = to_hsl
    #   hsl.h   *= percent
    #   hsl.to_rgb
    # end
  end
end
