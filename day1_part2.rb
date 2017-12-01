#!/usr/bin/env ruby -w

input = if ARGV[0]
          ARGV[0].chomp
        else
          File.read('day1.in').chomp
        end
digits = input.split(//).map(&:to_i)
digits_count = digits.size
step = digits_count / 2

sum = digits.each_with_index.select do |d, i|
  d == digits[(i + step) % digits_count]
end

puts sum.sum(&:first)
