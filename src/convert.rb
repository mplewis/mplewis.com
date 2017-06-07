#!/usr/bin/env ruby

require 'tilt'
require 'slim'

template = Tilt.new File.join File.dirname(__FILE__), %w(content template.slim)
output = template.render do
  '<h1>Hello world!</h1>'
end

puts output
