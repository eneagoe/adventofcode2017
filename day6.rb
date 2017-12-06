#!/usr/bin/env ruby -w

require 'set'

memory = File.read(ARGV[0]).split(/\s+/).map(&:to_i)
memory_size = memory.size

steps = 0
seen_configurations = Set.new

while !seen_configurations.include?(memory)
  seen_configurations << memory.dup
  max_blocks = memory.max
  max_blocks_position = memory.index(max_blocks)
  memory[max_blocks_position] = 0
  (1..max_blocks).each do |i|
    memory[(max_blocks_position + i) % memory_size] += 1
  end
  steps += 1
end

# answer for the first part of the puzzle
puts steps

# answer for the second part of the puzzle
# ATTN: relies on the fact that the set actually keeps the order of insertion
seen_configurations.each_with_index do |layout, idx|
  puts seen_configurations.size - idx if layout == memory
end
