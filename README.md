[![Gem Version](https://badge.fury.io/rb/color_palette.png)](http://badge.fury.io/rb/color_palette)

Color Palette
====================

**Making life of a programmer-designer easier.**

![alt tag](https://raw.githubusercontent.com/hsgubert/color_palette/master/palette_image.jpeg)

Simple gem to build palettes (sequence of colors) of various types based on one or more reference colors.This gem aims to be as simple as possible helping you to create palettes dynamically. No more hard-coding a lot of colors in your ruby code!

# Requirements

- Ruby 2.1 (untested for older versions of ruby, but it might as well work)

# Installation

Run
    gem install color_palette

Or add to your gemfile and run bundle install
    # Gemfile
    gem 'color_palette', :require => false
    # Terminal
    bundle install

# Reference

### Unidirectional Palette

A unidirectional palette is a a palette that goes from a start color (usually white) to a goal color. See examples of unidirectional palettes below:

(pending)

Here is how to create them using the color_palette gem:

```ruby
# Creating palette from white to red, with 5 colors
ColorPalette.unidirectional('#FF0000', 5) 

# Creating palette from white to green, with 50 colors
ColorPalette.unidirectional('#00FF00', 50)

# Creating palette from black to blue, with 20 colors
ColorPalette.unidirectional('#0000FF', 20, start_color: '#000000')

# Creating palette from red to green, with 10 colors
ColorPalette.unidirectional('#00FF00', 10, start_color: '#FF0000')
```

### Color Formats

The colors may be specified with or without hashtag, and in 6 digit code or 3 digit code. Codes are case insensitive. Examples of specifying the red color:
```
'#FF0000'
'#ff0000'
'FF0000'
'ff0000'
'#F00'
'#f00'
'F00'
'f00'
```
