#!/usr/bin/env ruby -w

input = File.readlines(ARGV[0])

start_a = input[0].chomp.split().last.to_i
start_b = input[1].chomp.split().last.to_i

a_factor = 16807
b_factor = 48271
divider = 2147483647
steps = 40_000_000
bits = 2**16

a, b = start_a, start_b
judge_total = (1..steps).count do
  a = (a * a_factor) % divider
  b = (b * b_factor) % divider
  a % bits == b % bits
end

# solution to first part of the puzzle
puts judge_total

pairs = 5_000_000
second_judge_total = 0

a, b = start_a, start_b
GeneratorA = Enumerator.new do |yielder|
  loop do
    a = (a * a_factor) % divider
    yielder.yield(a) if (a % 4).zero?
  end
end

GeneratorB = Enumerator.new do |yielder|
  loop do
    b = (b * b_factor) % divider
    yielder.yield(b) if (b % 8).zero?
  end
end

second_judge_total = (1..pairs).count do
  next_a = GeneratorA.next
  next_b = GeneratorB.next
  next_a % bits == next_b % bits
end

# solution to second part of the puzzle
puts second_judge_total
