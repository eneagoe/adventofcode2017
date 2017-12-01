#!/usr/bin/env ruby -w

input = if ARGV[0]
          ARGV[0].chomp
        else
          File.read('day1.in').chomp
        end
digits = input.split(//).map(&:to_i)

sum = digits.each_with_index.select do |d, i|
  d == digits[(i + 1) % digits.size]
end

puts sum.sum(&:first)

