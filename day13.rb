#!/usr/bin/env ruby -w

require 'ap'

firewall = {}

File.open(ARGV[0]).each do |line|
  layer, depth = line.chomp.split(/:\s*/).map(&:to_i)
  firewall[layer] = depth
end

delay = 0
safe = false

while !safe
  severity = 0
  safe = true
  firewall.each do |k, v|
    if (k + delay) % (2*v - 2) == 0
      severity += v*k
      safe = false
    end
  end
  puts severity if delay.zero? # solution for the first part of the puzzle

  delay += 1
end

# solution for the second part of the puzzle
print delay - 1
