#!/usr/bin/ruby -w

require 'awesome_print'

# input
steps = 356

spinbuffer = [0]
spinlen = 1
spinposition = 0

(1..2017).each do |i|
  spinposition = (spinposition + steps) % spinlen + 1
  spinbuffer.insert(spinposition, i)
  spinlen += 1
end

# solution to first part of the puzzle
puts spinbuffer[spinposition + 1]

second_solution = 0
spinposition = 0
spinlen = 1
(1..50000000).each do |i|
  spinposition = (spinposition + steps) % spinlen + 1
  spinlen += 1
  if spinposition == 1
    second_solution = i
  end
end

# solution to second part of the puzzle
puts second_solution
