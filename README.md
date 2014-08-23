[![Gem Version](https://badge.fury.io/rb/color_palette.png)](http://badge.fury.io/rb/color_palette)

Color Palette
====================

**Making life of a programmer-designer a little easier.**

![alt tag](https://raw.githubusercontent.com/hsgubert/color_palette/master/images/palette_image.jpeg)

Simple gem to build palettes (sequence of colors) of various types based on one or more reference colors.This gem aims to be as simple as possible helping you to create palettes dynamically. No more hard-coding a lot of colors in your ruby code!

# Requirements

- Ruby 2.1 (untested for older versions of ruby, but it might as well work)

# Installation

Run
    gem install color_palette

Or add to your gemfile and run bundle install

```ruby
# Gemfile
gem 'color_palette', :require => false
# Terminal
bundle install
```
# Reference

### Unidirectional Palette

A unidirectional palette is a a palette that goes from a start color (usually white) to a goal color. See examples of unidirectional palettes below:

![alt tag](https://raw.githubusercontent.com/hsgubert/color_palette/master/images/example1.png)
![alt tag](https://raw.githubusercontent.com/hsgubert/color_palette/master/images/example2.png)
![alt tag](https://raw.githubusercontent.com/hsgubert/color_palette/master/images/example3.png)
![alt tag](https://raw.githubusercontent.com/hsgubert/color_palette/master/images/example4.png)

Here is how to create palettes alike using the color_palette gem:

```ruby
# ColorPalette.unidirectional(end_color, palette_size, start_color = white)

# Creating palette from white to red, with 5 colors
ColorPalette.unidirectional('#ff0000', 5)
# => ["#ffffff", "#ffbfbf", "#ff8080", "#ff4040", "#ff0000"]

# Creating palette from white to green, with 3 colors
ColorPalette.unidirectional('#00FF00', 3)
# => ["#ffffff", "#80ff80", "#00ff00"]

# Creating palette from black to blue, with 4 colors
ColorPalette.unidirectional('#0000FF', 4, '#000000')
# => ["#000000", "#000055", "#0000aa", "#0000ff"] 

# Creating palette from red to green, with 10 colors
ColorPalette.unidirectional('#00FF00', 6, '#FF0000')
# => ["#ff0000", "#cc3300", "#996600", "#669900", "#33cc00", "#00ff00"]
```

### Color Formats

The colors may be specified with or without hashtag, and in 6 digit code or 3 digit code. Codes are case insensitive. Examples of specifying the red color:
```ruby
'#FF0000'
'#ff0000'
'FF0000'
'ff0000'
'#F00'
'#f00'
'F00'
'f00'
```
