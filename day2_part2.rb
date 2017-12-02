#!/usr/bin/env ruby -w

# quadratic time, not very efficient
checksum = File.open(ARGV[0]).reduce(0) do |sum, line|
  nr = line.split(/\s+/).map(&:to_i)
  divisible_pair = nr.product(nr).detect do |a, b|
    a != b && (a % b == 0 || b % a == 0)
  end
  sum += divisible_pair.max / divisible_pair.min
end

puts checksum
