
# loads file with version constant
$:.push File.expand_path("../lib", __FILE__)
require "color_palette/version"

Gem::Specification.new do |s|
  s.name        = 'color_palette'
  s.version     = ColorPalette::VERSION.dup
  s.date        = '2014-08-23'
  s.license     = 'MIT'
  s.summary     = 'Simple gem to build palettes (sequence of colors) of various types based on one or more reference colors.'
  s.description = 'This gem aims to be as simple as possible helping you to create palettes dynamically. No more hard-coding a lot of colors in your ruby code!'
  s.authors     = ['Henrique Gubert']
  s.email       = ['guberthenrique@hotmail.com']
  s.homepage    = 'https://github.com/hsgubert/color_palette'
  s.require_path = 'lib'
  s.required_rubygems_version = '>= 1.8.0'

  # s.files: The files included in the gem.
  s.files = Dir['lib/**/*']

  # s.test_files: Files that are used for testing the gem.
  s.test_files = Dir['spec/**/*_spec.rb']

  # s.executables: Executables that comes with the gem
  #s.executables = ['exec_name']

  # s.add_dependency: Production dependencies
#  s.add_dependency 'rake', '~> 10'

  # s.add_development_dependency: Development dependencies
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'byebug', '~> 3.2'
  s.add_development_dependency 'bundler', '~> 1.7'
end
