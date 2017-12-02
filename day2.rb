#!/usr/bin/env ruby -w

checksum = File.open(ARGV[0]).reduce(0) do |sum, line|
  line = line.split(/\s+/).map(&:to_i)
  sum += (line.max - line.min)
end

puts checksum
