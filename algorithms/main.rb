# frozen_string_literal: true

require_relative 'fibonacci'
require_relative 'excel'
require 'debug'

puts Fibonacci.calculate_iterative(5)
puts
puts Fibonacci.calcule_recursive(6)
puts
puts "A: #{Excel.index('A')}"
puts "B: #{Excel.index('B')}"
puts "C: #{Excel.index('C')}"
puts
puts "AA: #{Excel.index('AA')} - 27"
puts "BB: #{Excel.index('BB')} - 54"
puts "CC: #{Excel.index('CC')} - 81"
puts
puts "AAA: #{Excel.index('AAA')} - 703"
puts "BBB: #{Excel.index('BBB')} - 1406"
puts "CCC: #{Excel.index('CCC')} - 2109"